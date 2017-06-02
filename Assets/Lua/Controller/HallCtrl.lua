--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

require "Common/config"
require "Common/define"
require "Logic/GameMain"
require "Logic/Packing"
HallCtrl = {};
local this = HallCtrl;

local message;
local transform;
local gameObject;
 local bIsReLoginType = false;--是否为重连登录方式
--构建函数--
function HallCtrl.New()
	log("HallCtrl.New--->>");
	return this;
end

function HallCtrl.Awake()
	log("HallCtrl.Awake--->>");
    Event.AddListener(Evt.NET_STATE_CONNECTED,this.OnConnect); 
	Event.AddListener(Evt.NET_CMD_LOGIN_BACK,this.GetDataLoginBack); 
	Event.AddListener(Evt.NET_CMD_START_GAME_BACK, this.GetDataStartGameBack); 
    Event.AddListener(Evt.NET_CMD_HALL_PLAYER_INFO_GET_BACK, this.GetHallPlayInfo); 
    Event.AddListener(Evt.NET_CMD_HALL_RANK_GET_BACK, this.GetHallRankInfo); 
    Event.AddListener(Evt.NET_CMD_HALL_FISH_TYPE_GET_BACK, this.GetHallFishType); 
    Event.AddListener(Evt.NET_CMD_HALL_ROOM_GROUP_LIST_GET_BACK, this.GetHallGroupList);
   HallCtrl.HallInit();
end
function HallCtrl.HallInit(args)
    panelMgr:CreatePanel('Hall', this.OnCreate);
end
--启动事件--
function HallCtrl.OnCreate(obj)
	gameObject = obj;
	local panel = gameObject:GetComponent('UIPanel');
	panel.depth = 10;	--设置纵深--

	message = gameObject:GetComponent('LuaBehaviour');
	message:AddClick(HallPanel.QuickStart, this.OnQuickStartClick);
    bundle= resMgr.LoadBundle("HallFishPanel");
   bundle.Load();
	log("Start lua--->>"..gameObject.name);
end

--单击事件--
function HallCtrl.OnQuickStartClick(go)
    FastEnterRoom();
end

--关闭事件--
function HallCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Hall);
end


--打开遮罩
function HallCtrl.OpenMask()
    log("OpenMask");
	this.mask:SetActive(true);
end

--关闭遮罩
function HallCtrl.CloseMask()
    log("CloseMask");
	this.mask:SetActive(false);
end

function HallCtrl.OnDestroy()
	logWarn("HallCtrl OnDestroy---->>>");
    destroy(gameObject);
end
function HallCtrl.AutoLogin()	
     networkMgr:SendConnect(config.gameServerIp, config.gameServerPort);
 end
	--解析登陆返回的数据
function HallCtrl.GetDataLoginBack(hashtbl)
		
	local ret = hashtbl["ret"];
	if ret ~= 0 then
		local msg = hashtbl["msg"];
         log("GetDataLoginBack"..msg);
        -- block user input for fire
		config.pause = true;
		config.muteGame(true);
	else

		playerModel.UserId = hashtbl["userId"];
		playerModel.LoginId = hashtbl["loginId"];
		playerModel.LoginKey = hashtbl["key"];
		logWarn("GetDataLoginBack ---->>>");
		Packing.StartGame(playerModel.UserId, playerModel.LoginId , 1);
        config.pause = false;
	end
end	

--获取首次进入大厅返回的数据
function HallCtrl.GetDataStartGameBack(hashtbl)
		
	local ret = hashtbl["ret"];
	if ret ~= 0 then
		local msg = hashtbl["msg"];
          logWarn("GetDataStartGameBack 11111");
	else
		--加载大厅
	
      -- sceneMgr.AsyncLoadScene(1,LoadAsysncScene);
     
        --if hashtbl.usertoken ~=nil then
        --  _playerModel.UserToken = hashtbl[NETFields.K_USER_TOKEN];
        --end
        -- logWarn("GetDataStartGameBack ---->>>"..  _playerModel.UserToken);
        Packing.GetHallInfo();
      
    scenesMgr:AsyncLoadScene(1,this.LoadLevelAsysnc);
          log("HallCtrl Init Start");
    --    local ctrl = CtrlManager.GetCtrl(CtrlNames.Hall);
    --    if ctrl ~= nil and AppConst.ExampleMode == 0 then
    --        ctrl:Awake();
    --end
    end
end
function  HallCtrl.GetHallPlayInfo(hashtbl)
        log(hashtbl.tolstring);
         log("HallCtrl GetHallPlayInfo");
end
function  HallCtrl.GetHallRankInfo(hashtbl)
        log(hashtbl.tolstring);
         log("HallCtrl GetHallRankInfo");
end

function  HallCtrl.GetHallFishType(hashtbl)
        log(hashtbl.tolstring);
         log("HallCtrl GetHallFishType");
end
function  HallCtrl.GetHallGroupList(hashtbl)
        log(hashtbl.tolstring);
         log("HallCtrl GetHallGroupList");
end
function HallCtrl.LoadLevelAsysnc()
         log("HallCtrl Init Start0");
                 local ctrl = CtrlManager.GetCtrl(CtrlNames.Hall);
        if ctrl ~= nil and AppConst.ExampleMode == 0 then
            ctrl:Awake();
    end
end
function HallCtrl.OnConnect()
	--关闭遮罩
    log("HallCtrl Receive NET_STATE_CONNECTED");
    StartCoroutine(this.StartLogin);
end
function  HallCtrl.StartGame()
end
function  HallCtrl.StartLogin()
	    
		while (GameMain.gameInitDone==false) 
        do		
			 WaitForSeconds(0.1);	
              log("HallCtrl StartLogin");	
        end    
         
     --  Login_Server("cd01", "cd01", "01");
       local token="";
       if bIsReLoginType==true then 
         token= playerModel.UserToken;
       else
         token=playerModel.Pass;
       end
         log(string.format("_playerModel.Account:%s _playerModel.Pass:%s token: %s playerModel.PidToken:%s",                            playerModel.Account, playerModel.Pass,token,playerModel.PidToken));
        Packing.Login(playerModel.Account,token, playerModel.ProductId, playerModel.PidToken, bIsReLoginType,GameMain.bRelogin);
        log("Init111#### ");

   --     StartGame
      --  _network.SendPacket(tbl);
end