--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--init by YY 2017-2-27 

--endregion
require "Module/playerModel"
GameMain = {};
local this = GameMain;
this.gamePause = false;
this.gameInitDone = false;
 
-- 重连编号
this.bRelogin = 0;
this.BGAUIDO_NUM = 5;

this.audioVolume=0.8;
this.clipHunt={};
this.clipHall=nil;
this.clipLoading=nil;
this.clipBalanceBgm=nil;
this.clipLotteryBgm=nil;
this.clipFightBossBgm=nil;
this._bPlayBGAudio = false;
this.timeAudioPlaying = 0;
--记录上次进入房间的房号
local nextId = -1;
      
  
function GameMain.Awake(obj) 
        audioVolume = config.music_volume;
        UpdateBeat:Add(this.Update,self);
        StartCoroutine(this.Init);
end
   -- Use this for initialization
--构建函数--
function GameMain.New()
	logWarn("GameMainCtrl.New--->>");
	return GameMain;
end
   
function GameMain.Init()
  
        if this.gameInitDone ==true then 
            Yield(nil);
        end
        log("Init####");
        --下载配置文件,读取配置信息
        config.initConfData();
        playerModel.AutoLogin = true;
         log("Init222####");
        --[[
#if _PC
        player.Account = "hk08";
        player.Pass = "hk08";
        PlayerModel.NickName = LoginView.Instance._userNickName;//player.UserName;
        player.AccessOpenID = LoginView.Instance._userOpenID;
        player.UserIconURL = LoginView.Instance._userIcon;
        PlayerModel.ProductId = "01"; //"01";
        player.PidToken = LoginView.Instance.pidToken;
        PlayerPrefs.SetString("PID", PlayerModel.ProductId);
#else
--]]
        playerModel.Account = LoginCtrl._userOpenID;  --"hk08"; 
        playerModel.Pass = LoginCtrl._userToken;--"hk08";
        playerModel.NickName =LoginCtrl._userNickName;--/player.UserName;
        playerModel.AccessOpenID =LoginCtrl._userOpenID;
        playerModel.AccessUserUnionID =LoginCtrl._userUnionID;
        playerModel.UserIconURL = LoginCtrl._userIcon;
        playerModel.ProductId = config.productId; --"01";
        playerModel.PidToken = config.pidToken;
        PlayerPrefs.SetString("PID", playerModel.ProductId);

        playerModel.IsLoginEnter = true;

        log("Init000111#### playerModel.Account:"..playerModel.Account.."playerModel.Pass:"..playerModel.Pass);
        --执行将Icon 拷贝到对应文件夹下
        --暂时取消，到时候与更新时统一copy
        -- Yield(StartCoroutine(config.SetIconUrl)) ;

           local ctrl = CtrlManager.GetCtrl(CtrlNames.Hall);
    if ctrl ~= nil and AppConst.ExampleMode == 0 then
        ctrl:Awake();
    end


        this.StartGame();
    
        this.gameInitDone = true;
        --clipHall= soundMgr.LoadAudioClip(word.BGROUNDCLIPS_HALL_BGM);
        --clipLoading = soundMgr.LoadAudioClip(word.BGROUNDCLIPS_LOAD_BGM);
        --for  i = 1, i<= BGAUIDO_NUM do       
        --    clipHunt[i] =soundMgr.LoadAudioClip(word.BGROUNDCLIPS_HUNT_BGM .. tostring(i));
        --end
        --clipBalanceBgm =soundMgr.LoadAudioClip(word.SCENECLIPS_BANLANCE_BGM);
        --clipLotteryBgm =soundMgr.LoadAudioClip(word.SCENECLIPS_BOSSCLIPS_LOTTERY_BGM);
        --clipFightBossBgm =soundMgr.LoadAudioClip(word.SCENECLIPS_BOSSCLIPS_BOSS_BGM);
        --]]    
  end
 
function GameMain.ChangeAccountLogin()   

    playerModel.AutoLogin = true;
    playerModel.Account = LoginCtrl._userOpenID; -- "hk08"; 
    playerModel.Pass = LoginCtrl._userToken; -- "hk08"; 
    playerModel.NickName = LoginCtrl._userNickName;--player.UserName;
    playerModel.AccessOpenID = LoginCtrl._userOpenID;
    playerModel.UserIconURL = LoginCtrl._userIcon;
    playerModel.ProductId = "TST"; --"01"; 
    playerModel.PidToken = LoginCtrl.pidToken;
    PlayerPrefs.SetString("PID", playerModel.ProductId);
    playerModel.IsLoginEnter = true;
    this.StartGame();
end
-- Update is called once per frame
function GameMain.Update()

    if _bPlayBGAudio==true then
    
        PlayHuntingBgm();
    end
end
 
     --开始游戏链接服务
function GameMain.StartGame()
log("AutoLogin");
     if  playerModel.AutoLogin==true and config.GetFishFromNet==true then		
             local hallCtrl = CtrlManager.GetCtrl(CtrlNames.Hall);
            if hallCtrl ~= nil and AppConst.ExampleMode == 0 then         
	        hallCtrl.AutoLogin();		
            end	
     end
end
    
    --进入不同场景，切换音乐，初始化和重置相关数据
function GameMain.OnLevelWasLoaded( level)
  local currentLevel= level;
   log("GameMain OnLevelWasLoaded:"..currentLevel);
  if currentLevel==1 then
        log("OnLevelWasLoaded:"..currentLevel);
        _bPlayBGAudio = false;
        audio.Stop();
        audio.clip = clipHall;
        audio.loop = true;
   elseif currentLevel==2    then     
        audio.Stop();
        audio.loop = false;
        _bPlayBGAudio = true;
   elseif currentLevel==3 then
        _bPlayBGAudio = false;
        audio.Stop();
        audio.clip = clipLoading;
        audio.loop = true;
        audio.Play();

    elseif currentLevel==0 then
        audio.Stop();
        audio.clip = null;
    end
     
        Event.Brocast(Evt.CMD_LEVEL_LOADED, level);
      --  EventManager.SendEvent(Evt.CMD_LEVEL_LOADED, level);
    end
  
    function GameMain.PlayHuntingBgm()   
        local index = 0;
        if audio.isPlaying==false then
        
            index = Random.Range(0, BGAUIDO_NUM - 1);
            audio.clip = clipHunt[index];
            audio.Play();
        end
    end
   --[[
    /// <summary>
    /// 开始播放大厅的背景音乐
    /// </summary>
    --]]
    function GameMain.StartHallBgm()
    
        if Application.loadedLevel == Config.HALL_VIEW_LEVEL then
        
            _bPlayBGAudio = false;
            audio.Stop();
            audio.clip = clipHall;
            audio.loop = true;
            audio.Play();
        end
    end
    --[[
    /// <summary>
    /// 停止播放游戏音乐
    /// </summary>
    --]]
    function GameMain.StopHallBgm()
    
        if Application.loadedLevel == Config.HALL_VIEW_LEVEL then        
            _bPlayBGAudio = false;
            audio.Stop();
            Debug.Log("Stop play backAudio!");
        end
    end
    --[[
    //插播播放结算背景音乐
    //0:结算背景音乐
    //1:抽奖背景音乐 
    //2:boss出现背景音乐
    --]]
    function GameMain.PlayResultBgm( iType)
    --[[
        _bPlayBGAudio = false;
        audio.Stop();
        audio.loop = true;
        if iType==0 then    
           audio.clip = clipBalanceBgm; 
        else if iType ==1
                audio.clip = clipLotteryBgm;
        else if iType ==2
                audio.clip = clipFightBossBgm;          
        end
        audio.Play();
        --]]
    end

--停止插播播放结算背景音乐
function GameMain.StopResultBgm()
    
    audio.loop = false;
    _bPlayBGAudio = false;
    audio.Stop();
end
       
function GameMain.OnDestroy()    
    -- Utils.GetNetwork().CloseConnectTest();    
end