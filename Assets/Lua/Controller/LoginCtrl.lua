require "Common/define"
require "Common/config"
require "Logic/InternalEvent"
require "Logic/Packing"
require "Logic/UIPanelBase"
json_Instance = require('Common/json')
LoginCtrl = UIPanelBase:New();
local this = LoginCtrl;

local panel;
local Login;
local transform;
local gameObject;
local application = UnityEngine.Application;

    --用户数据
--local account = "";
--local passward = "";
--local productId = "TST";
--local pidToken = "d84b062c76a87a73888";
--微信登录平台验证参数
this._userToken="";
this. _userNickName = "";
this. _userIcon = "";
this. _userOpenID="";
this. _userUnionID="";--获取用户的unionid
local _sing="" ;
local _md5Key = "qunle2016ShenZhen";
local strAction = "/Hunter/Index/wxlogin?";
local strTryAction = "/Hunter/Index/trylogin?";

local toolTipPanel = nil;
local contentValue=nil;
local exitBtn = nil;
local leftButtonPos = {x=-162,y=-143,z=0};
local middleButtonPos = {x =10,y= -143,z= 0};
local rightButtonPos =  {x=172,y=-143,z=0};
local loginContent = nil;
local coHandleAuthFromShareSDK=nil;
local coRequestURLBack=nil;
--构建函数--
function LoginCtrl.New()
	log("LoginCtrl.New--->>");
	return LoginCtrl;
end

function LoginCtrl.Awake()
	log("LoginCtrl.Awake--->>");
	panelMgr:CreatePanel('Login', this.OnCreate);
end

--启动事件--
function LoginCtrl.OnCreate(obj)
	gameObject = obj;
	transform = obj.transform;

	panel = transform:GetComponent('UIPanel');
	Login = transform:GetComponent('LuaBehaviour');
	log("Start lua--->>"..gameObject.name);

	Login:AddClick(LoginPanel.wechatLoginBtn, this.btnQRLogin_OnClick);
    Login:AddClick(LoginPanel.guessLoginBtn, this.btnQRLogin_OnClick);
    Login:AddClick(LoginPanel.compcatBtn,this.ShowUserCompactPanel);
    local ctrl = CtrlManager.GetLogicCtrl(CtrlLogicNames.SendPing);
    if ctrl ~= nil and AppConst.ExampleMode == 0 then
        ctrl:Awake();
    end
    this.ShowLogin(); 
    --[[
	AppConst.SocketPort = 7700;
    AppConst.SocketAddress = "hz.qunl.com";
    networkMgr:SendConnect();
    --]]
end

--单击事件--
     
    
function LoginCtrl.btnQRLogin_OnClick(go)   
    if LoginPanel.GetcompcatToggleValue()==false then      
        LoginPanel.ShowLoginNotice(word.LOGIN_USER_COMPACAT_TIP, 3);
        return;
    end
    --后续微信验证

    this._userIcon = "";
    this._userToken = "";
    this.ShowAllLoginBtns(true);
    if go.name=="TryLogin" then
        
        _bTryUser = true;
        if PlayerPrefs.HasKey("Login OpenID")==true then          
            this._userOpenID = PlayerPrefs.GetString("Login OpenID");            
        else           
            this._userOpenID = Util.getGUID();
            PlayerPrefs.SetString("Login OpenID", this._userOpenID);           
        end
        
        if PlayerPrefs.HasKey("Login NickName")==true then          
            this._userNickName = PlayerPrefs.GetString("Login NickName");           
        else           
            this._userNickName = "Guest".. tostring(math.random(0, 1000));       
            PlayerPrefs.SetString("Login NickName", this._userNickName);
        end   
        log("_userOpenID="..this._userOpenID.." NickName="..this._userNickName);
         coHandleAuthFromShareSDK = coroutine.create(this.HandleAuthFromShareSDK);
           if coHandleAuthFromShareSDK ~=nil then
             coroutine.resume(coHandleAuthFromShareSDK);
           end
        
    else   
        _bTryUser = false;
       local bNeedLoignWeChart=false;
        if PlayerPrefs.HasKey("LoginWeChart openID") then      
            _userOpenID = PlayerPrefs.GetString("LoginWeChart openID");       
        else      
            bNeedLoignWeChart = true;
        end

        if PlayerPrefs.HasKey("LoginWeChart unionid") then
        
            _userUnionID = PlayerPrefs.GetString("LoginWeChart unionid");       
        else       
            bNeedLoignWeChart = true;
        
        end
        if PlayerPrefs.HasKey("LoginWeChart userName") then
        
            _userNickName = PlayerPrefs.GetString("LoginWeChart userName");      
        else       
            bNeedLoignWeChart = true;
        end
        if PlayerPrefs.HasKey("LoginWeChart userIcon") then        
            _userIcon = PlayerPrefs.GetString("LoginWeChart userIcon");       
        else       
            bNeedLoignWeChart = true;
        end
        bNeedLoignWeChart = bNeedLoignWeChart or GameMain.gameInitDone;
        if  bNeedLoignWeChart  then
        
            LoginPanel.ShowLoginNotice(word.LOGIN_WAITFOR_WECHART_TIP);
            _bWechartLogining = true;  
            scenesMgr:ShareSDKInit(config.appKey,config.appID,config.appSecret,this.CallBackShareSDKArgs);             
            --ssdk.Authorize(PlatformType.WeChat);    
            
        else        
           coHandleAuthFromShareSDK = coroutine.create(this.HandleAuthFromShareSDK());
           if(coHandleAuthFromShareSDK ~=nil) then
             coroutine.resume(coHandleAuthFromShareSDK);
           end
        end           
     end      
end
--[[
微信shareSDK回调微信用户参数

--]]
function LoginCtrl.CallBackShareSDKArgs(resultCode, userOpenID, userUnionID , userIcon ,userNickName )
    log("CallBackShareSDKArgs:".."resultCode"..resultCode);
    if resultCode~=1 then
       this._userOpenID= userOpenID;
       this.userUnionID= userUnionID ;
       this.userIcon= userIcon;
       this.userNickName=userNickName;
       coHandleAuthFromShareSDK = coroutine.create(this.HandleAuthFromShareSDK());
       if(coHandleAuthFromShareSDK ~=nil) then
          coroutine.resume(coHandleAuthFromShareSDK);
       end
    end
end
--[[
    /// <summary>
    /// 显示用户协议UI
    /// </summary>
--]]
    function LoginCtrl.ShowUserCompactPanel()   
       LoginPanel.comcatPanel.gameObject:SetActive(true);
       LoginPanel.userCompacatScroll:ResetPosition();
    end


function LoginCtrl.LoadAsysncScene()
    local Scenes= UnityEngine.Application.LoadAsysncScene(1);
    Yield(Scenes);
    log("finsh");
end
--大厅场景加载完毕事件通知
function  LoginCtrl.OnLevelWasLoad(levelSceneID)
 log("Hall Load Completed");
end
--关闭事件--
function LoginCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Login);
end

--[[
    /// <summary>
    /// 展示登陆界面
    /// </summary>
    /// <returns></returns>
    --]]     
function LoginCtrl.ShowLogin()
    
-- UNITY_EDITOR&&(UNITY_ANDROID||UNITY_IOS)
    config.LoginType = 0;
--#elif UNITY_STANDALONE
    --    Config.LoginType = 2;
--#endif
    log("show Login button:" .. tostring(config.LoginType));
    if config.LoginType==1 then        
        --只有微信登录
        LoginPanel.guessLoginBtn.gameObject:SetActive(false);
        Util.SetObjLocalPos(LoginPanel.wechatLoginBtn,middleButtonPos["x"],middleButtonPos["y"],middleButtonPos["z"]);
        LoginPanel.wechatLoginBtn.gameObject:SetActive(true);       
    elseif config.LoginType == 2 then
        
        --只有游客登录
        Util.SetObjLocalPos( LoginPanel.guessLoginBtn,middleButtonPos["x"],middleButtonPos["y"],middleButtonPos["z"]);
        LoginPanel.guessLoginBtn.gameObject.SetActive(true);
        LoginPanel.wechatLoginBtn.gameObject.SetActive(false);            
    else      
        --混合登录
        
        Util.SetObjLocalPos(LoginPanel.guessLoginBtn,leftButtonPos["x"],leftButtonPos["y"],leftButtonPos["z"]);
        Util.SetObjLocalPos(LoginPanel.wechatLoginBtn,rightButtonPos["x"],rightButtonPos["y"],rightButtonPos["z"]);
        LoginPanel.guessLoginBtn.gameObject:SetActive(true);
        LoginPanel.wechatLoginBtn.gameObject:SetActive(true);
    end
    LoginPanel.compcatToggle.gameObject:SetActive(true);
    LoginPanel.compcatBtn.gameObject:SetActive(true);
    LoginPanel.loginContent:SetActive(true);       
end
     --显示各按钮信息    
function LoginCtrl.ShowAllLoginBtns(Show)   
    LoginPanel.loginContent:SetActive(Show);
    LoginPanel.wechatLoginBtn:SetActive(Show);
    LoginPanel.guessLoginBtn:SetActive(Show);
    LoginPanel.compcatToggle.gameObject:SetActive(Show);
    LoginPanel.compcatBtn.gameObject:SetActive(Show);
end

   --根据openid向后台申请登录token
function LoginCtrl.HandleAuthFromShareSDK()    
    LoginPanel.ShowLoginNotice(word.LOGIN_WAIT_TIP);
    local strLoginAuthUrl = ""; 
    local Action="";
    if _bTryUser==true then
        Action=strTryAction;
    else
        Action=strAction;
    end    
    log("_userOpenID="..this._userOpenID.." NickName="..this._userNickName);
    strLoginAuthUrl= this.GetLoginTokenURL(_bTryUser,this._userOpenID,this._userUnionID,  this._userNickName, this._userIcon,Action);
    log("strLoginAuthUrl:  "..strLoginAuthUrl);
    if strLoginAuthUrl=="" then
        
        LoginPanel.ShowLoginNotice(word.LOGIN_FAIL_TIP, 3);
        this.ShowLogin();
        _bWechartLogining = false;
        return;
    end
    -- Debug.Log("strLoginAuthUrl" + strLoginAuthUrl);
     coRequestURLBack= coroutine.create(this.RequestURLBack);
    coroutine.resume(coRequestURLBack,strLoginAuthUrl,"data");
    coroutine.yield();
    log("HandleAuthFromShareSDK resurme");
    if this._userToken ~= "" then         
    --_userToken 获取成功
    log("_userToken="..this._userToken);
--      local ctrl = CtrlManager.GetLogicCtrl(CtrlLogicNames.SendPing);
--    if ctrl ~= nil and AppConst.ExampleMode == 0 then
--        ctrl:Awake();
--    end
   local ctrl = CtrlManager.GetLogicCtrl(CtrlLogicNames.Main);
    if ctrl ~= nil and AppConst.ExampleMode == 0 then
        ctrl:Awake();
    end
   -- LoginGuistOnClick();

    _bWechartLogining = false;         
    end    
end
 function  LoginCtrl.GetLoginTokenURL( bTryUser,  userOpenId, userUnionId,  userNickName,  userPhotoUrl, strAction)    
    local strLoginAuthUrl ="";
    local strSign ={};
    local form = {}; 
    log("userOpenId="..userOpenId.." userNickName="..userNickName .. "strAction= " ..strAction);  
    table.insert(strSign,userOpenId);
    if bTryUser==false then       
     table.insert(form,string.format("%s=%s&","openid",userOpenId)); -- form["openid"]= userOpenId;
     table.insert(form,string.format("%s=%s&","unionid",userUnionId));--form["unionid"]= userUnionId; 
         table.insert(strSign,userUnionId);      
    else      
      table.insert(form,string.format("%s=%s&","username",userOpenId))--form["username"]= userOpenId;
    end
    table.insert(form,string.format("%s=%s&","nick",userNickName))--form["nick"]= userNickName;
     table.insert(strSign,userNickName); 
    if bTryUser==false then       
       table.insert(form,string.format("%s=%s&","photourl",userPhotoUrl)) -- form["photourl"]= userPhotoUrl;
         table.insert(strSign,userPhotoUrl); 
         table.insert(form,string.format("%s=%s&","gameid",config.PayParamGameID)) --form["gameid"] =config.PayParamGameID;
         table.insert(strSign,config.PayParamGameID); 
    end

    local timeStamp = tostring(os.time());
    table.insert(form,string.format("%s=%s&","timestamp",timeStamp))-- form["timestamp"]= timeStamp;
     table.insert(strSign,timeStamp); 
    table.insert(strSign,config.strMd5Key); 
    local md5Src=table.concat(strSign);
    local strMd5 = Util.md5(md5Src);
    table.insert(form,string.format("%s=%s","sign",strMd5))--form["sign"]= strMd5;
    log("form=".. json.encode(form));
    local strInputParam = table.concat(form);
    strLoginAuthUrl=string.format("%s%s:%s%s%s", config.httpAdress, config._IpAdd,tostring(config.httpWebServerPort), strAction, strInputParam);
    return strLoginAuthUrl;
end

        
function LoginCtrl.RequestURLBack( url, patternParm)   
   local www = WWW(url);
   coroutine.www(www);
   _bIsLoinging = false;
   if www.error ~= nil then        
        LogError("LoginError:" + www.error);
        this.ShowLoginNotice(word.LOGIN_FAIL_TIP,3);
        ShowLogin();
        _bWechartLogining = false;
        coroutine.resume(coHandleAuthFromShareSDK);
       return;
   end

   if www.text == "" then        
        this.ShowLoginNotice(word.LOGIN_FAIL_TIP,3);
        ShowLogin();
        _bWechartLogining = false;
        coroutine.resume(coHandleAuthFromShareSDK);
        
        return;       
   end
    log("www.text:" .. www.text);
   local k= string.find(www.text , "\"data\"") do    -- "(%a+)%s*=%s*(%a+)"  "(\"%w+\"):(\"%w+)\""
   local subString= www.text.sub(www.text,k+8);
   local  k2=string.find(subString,'"');
   local subString2= subString.sub(subString,0,k2-1);
   this._userToken=subString2;
    log("LoginView : RequestFrmoWeChartInfoBack， userToken=" ..this._userToken);  
    coroutine.resume(coHandleAuthFromShareSDK);
 end
end