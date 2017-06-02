--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
playerModel = {};
local this = playerModel;

     PlayerScene=
    {
        SCENE_LOGIN=1;
	    SCENE_HALL=2;
	    SCENE_ROOM=3;	
        SCENE_LOADING=4;
    }
    --当前场景id
   this.SceneId=PlayerScene.SCENE_LOGIN;
   --当前游戏id
   this.CurrentGameId=0;
   this.ReturnHall=false;
   --是否是自动登录
   this.AutoLogin=true;
   --用户登录id
   this.LoginId=0;
   --用户金额
   this.Money = 0;
   --用户id
   this.UserId=0;
   --用户座位id
   this.SeatId=0;
   --用户名称
   this.UserName="test";
   --用户openid
   this.AccessOpenID = "olBZPv8FSOKAhkbH2gpYbGCnIPQI";
   --用户微信应用唯一标识
   this.AccessUserUnionID= "";
    --用户头像
   this.UserIconURL="";
   --用户账号
   this.Account="";
   --用户密码
   this.Pass="";
   --用户产品id
   this.ProductId="";

   this.PidToken="";
   -- 玩家token，用于重连登录
   this.UserToken="";
   --添加用户携带的钻石
   this.UserDiamonds=0;
   --用户盈余
   this.CashEarn=0;
    -- 玩家token，用于重连登录
   this.UserToken=nil;

     --玩家的赠送密码
   this.UserPresentPwd="";

    -- 玩家绑定的电话号码
   this.UserTelephone="";
    
    -- 赠送时每次消耗金币数
   this.DonateExpand = 1000;
 
   -- 添加用户充值时绑定ID
   this.UserProxy=0;
    -- 用户绑定状态
   this.UserProxyState=0;

     -- 用户预绑定代理ID
   this.UserPreProxy="";
    
    --是否是登录进入大厅的
   this.IsLoginEnter=false;
     --是否进入私人房间
   this.IsEnterPrivateRoom=true;

	-- 添加用户领取救济金的次数
   this.UserAlmsNumber=0;

    -- 添加用户领取救济金的金额
   this.UserAlmsMoney=0;
   
--endregion
