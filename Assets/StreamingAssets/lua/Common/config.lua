--region *.lua
--Date
--init by yangyang 2017-2-22
--此文件由[BabeLua]插件自动生成
require "Common/define"
config = {};
local this = config;
DataPath=Util.DataPath;

	-- config for feature "Fixed Screen Ratio"
	-- 1920/1080 = 16:9
	 this.FixScreenRatio = true;
	 this.FixScreenRatioW = 1920;
	 this.FixScreenRatioH = 1080;

	 this.maxScreenWidth = 1280;--1920;    /// Aspect 16:9
	 this.maxScreenHeight = 720;--1080;   /// Aspect 16:9
	 this.originalScreenWidth = 1024; --1334;
	 this.originalScreenHeight = 576; --750;
    --[[
    /// <summary>
    /// 匹配后台版本号，用作通信验证
    /// </summary>
    --]]
	 this.communicationVersion = "v2.0";
   --[[
   /// <summary>
    /// 本地 客户端版本号
   /// </summary>
   --]]
     this.clientVersion = "1.0.2.0221";
     --[[
    /// <summary>
    /// 展示的版本号
    /// </summary>
    --]]
     this.showVersion = "Version_"..this.clientVersion;

     --[[
    /// <summary>
    /// 渠道号
    /// </summary>
    --]]
     this.clientChanel = "Qunle";

     --[[
    /// <summary>
    /// 是否下载鱼资源
    /// </summary>
    --]]
	 this.GetFishFromNet = true;

     --[[
    /// <summary>
    /// 资源下载路径
    /// </summary>
    --]]
	this.bundleURL = nil;
     --[[
    /// <summary>
    /// 公众号
    /// </summary>
    --]]
     this.pblicWeChatNum = "GAME4JOY";
     --[[
    /// <summary>
    /// qq群
    /// </summary>
    --]]
    this.qqGrop = "547993988";

    --[[
    /// <summary>
    /// 加盟咨询群
    /// </summary>
    --]]
    this.angencyqqGroupId = "612721717";

    --[[
    /// <summary>
    /// 是否使用 访问dnsapi来获取服务器
    /// </summary>
    --]]
     this.bDnsapi = 0;
     --[[
    /// <summary>
    /// 游戏运行环境是否异常
    /// </summary>
    --]]
    this.isException = false;

    this._IpAdd = "hz.qunl.com";--"116.251.239.82";"192.168.1.23";"hk.qunl.com";
    this.httpAdress = "http://";-- "http://"
    this.httpServerAddr = null;
    this.httpServerIp = null;
    this.httpServerPort = 0;
    this.productId = "TST";
    this.pidToken = "d84b062c76a87a73888";


    --[[
    /// <summary>
    /// 游戏是否暂停
    /// </summary>
    --]]
	 this.pause = false;
     --[[
    /// <summary>
    /// 音乐(music_volume)音效(audio_volume)的音量值
    /// </summary>
    --]]
    this.audio_volume = 0.8;
	this.music_volume = 0.8;
  
    --一些缩放比例
	this.particleZ = -2.4;
	this.bigWinParticleZ = -1;
	this.fishZ = 2;

    --场景编号
    this.LOGIN_VIEW_LEVEL = 0;
	this.HALL_VIEW_LEVEL = 1;
	this.FISHING_VIEW_LEVEL = 2;
    this.LOADING_VIEW_LEVEL = 3;
    this.BOUTRY_GOLD_COIN_VIEW_LEVEL = 4;
    this.ONLOOKING_VIEW_LEVEL = 5;

    this.NORMAL_FISHING_GAME_ID = 0;
    this.PRIVATE_FISHING_GAME_ID = 1;
    this.BOUTRY_GOLD_COIN_GAME_ID = 2;

     --[[
    /// <summary>
    /// 道具的固定Id
    /// </summary>
    --]]
    this.DIAMON_PROP_ID = 0;
    this.CASH_PROP_ID = 1;
    this.NUCBOMB_PROP_ID = 2;
    
	this.scaleCenterOffsetY=0;
    --[[
    /// <summary>
    /// 用户类型
    /// </summary>
    --]]
    this.userType = 0;

    this.autoReduceCannonCdTime = 3;
    --[[
    /// <summary>
    /// 投资买鱼开关(0开启，1不开启)
    /// </summary>
    --]]
    this.buyFish_onOff = 1;

    this.httpWebServerPort = 8090;--用于登录,支付的后台webserver的port  //https:92  //http:8090
    this.strMd5Key="qunle2016ShenZhen";
    this.fFishScale = 0.75; --用于test
    this.ActiveApplePay = false;
    this.IsCanShare = true;--是否可以分享
    this.LoginType = 2;  --登录类别0：混合登录模式  1：微信登录 2:游客登录
    this.PayParamGameID = 100;
    this.PayParamLevelID = 1;

    this.appDonaloadUrl = "joy.qunl.com/hunter.html";
    --微信登录相关参数
    this.appKey="17b0e7b703da0";
    this.appID="wx7548fc46de6bdfbf";
    this.appSecret="f2c0284f30088afe1f1ad4c8c8dc9037";
     --头像路径
    this.IconUrl = "";
    this.gameServerIp=nil;
    this.gameServerPort=0;
    --[[
    /// <summary>
    /// 初始化配置
    /// </summary>
    /// <returns></returns>
    --]]
    function config.initConfData()
		
		--¶ÁÈ¡ÉùÒôÅäÖÃ
        if PlayerPrefs.HasKey("AUDIO_VOLUME")==false then
        
            PlayerPrefs.SetFloat("AUDIO_VOLUME", this.audio_volume);
        
        else 
            this.audio_volume = PlayerPrefs.GetFloat("AUDIO_VOLUME");
        end
        if PlayerPrefs.HasKey("MUSIC_VOLUME")==false then
        
            PlayerPrefs.SetFloat("MUSIC_VOLUME", this.music_volume);        
        else        
            this.music_volume = PlayerPrefs.GetFloat("MUSIC_VOLUME");
        end
        if this.gameServerIp == nil then        
           this.gameServerIp = this._IpAdd;
        end

        if this.gameServerPort == 0 then        
            this.gameServerPort = 7700;
        end

        if this.httpServerIp == nil then       
            this.httpServerIp = this._IpAdd;
        end

        if this.httpServerPort == 0 then        
            this.httpServerPort = 7732;
        end
        if this.httpServerAddr == nil then
        
            this.httpServerAddr = httpServerIp .. ":" .. this.httpServerPort .. "/api";
        end
	end

	-- Set game music volume to zero or Config.music_volume
	function config.muteGame( isMute)	
		if this.isMute == true then		
			--GameObject.Find("main").GetComponent<AudioSource>().volume = 0f;		
		else		
			--GameObject.Find("main").GetComponent<AudioSource>().volume = music_volume;	
            end	
	end



    --保存声音设置
    function config.SaveVolume_WaterEffect()   

        Util:WritePlayerPrefs("AUDIO_VOLUME", audio_volume);
        PlayerPrefs.SetFloat("MUSIC_VOLUME", music_volume);
    end
   
   --用于分析 copy头像
    function config.SetIconUrl()   
         
        local infile ="file://"..UnityEngine.Application.streamingAssetsPath .."/Logo/buyulogo.png";
        local IconUrl =UnityEngine.Application.persistentDataPath .."/buyulogo.png";

       
        local file,err = io.open(IconUrl, "rb")
        if err==nil then io.close(file) end
        if err~=nil then  
            if Util.GetOS() == "Android" then   
                local www = UnityEngine.WWW(infile)
                Yield(www)
                 
                if www.error==nil then  
                     local iconFile,errCreate = io.open(IconUrl, "w")
                     if errCreate ==nil then  
                    local tmp=www.texture;   
                    log("www 222");                 
                     local s,s1;
                     s1=tmp:EncodeToPNG();
                      s=tolua.tolstring(s1);--EncodeToPNG()) ;
                    iconFile:write(s);
                     log(s); 
                    iconFile:close();
                    end            
                end
                 Yield(null) ;          
            else
            
                File.Copy(infile, IconUrl, true);
            end
             WaitForEndOfFrame();
        end
    end
    
   

  
