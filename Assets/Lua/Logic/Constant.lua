
NETOpcodes = {
	KEY = "op";

	--心跳包
	V_PING = 115;
	V_PING_BACK = 116;

	--被踢
	V_KICK_BACK = 10;

	--登录
	V_LOGIN = 3;
	V_LOGIN_BACK = 4;
	V_LOGIN_OUT = 7;

	--启动开始准备捕鱼大厅逻辑
	V_START_GAME = 5;
	V_START_GAME_BACK = 6;


    --请求返回捕鱼大厅
    V_HALL_ENTER                       = 401;
	V_HALL_ENTER_BACK                  = 402;

    --大厅请求获取用户信息
	V_HALL_PLAYER_INFO_GET				= 407;
	V_HALL_PLAYER_INFO_GET_BACK		= 408;

    --大厅信息获取
	V_HALL_INFO_GET					= 411;

    --鱼的类型消息返回
	V_HALL_FISH_TYPE_GET_BACK      	= 414;

    --请求获取大厅排行榜
    V_HALL_RANK_GET					= 459;
	V_HALL_RANK_GET_BACK				= 460;

	V_HALL_ROOM_GROUP_LIST_GET_BACK 	= 462;

    --大厅房间信息列表
	V_HALL_ROOM_LIST_GET				= 463;
	V_HALL_ROOM_LIST_GET_BACK			= 464;

    --请求大厅房间信息
	V_HALL_ROOM_INFO_GET				= 465;
	V_HALL_ROOM_INFO_GET_BACK			= 466;

    --普通进入具体倍率房间
	V_HALL_ROOM_ENTER					= 467;
	V_HALL_ROOM_ENTER_BACK				= 468;

    --快速进入所在倍率房间(快速开始游戏)
	V_HALL_ROOM_FAST_ENTER				= 469;
    
    -- 离开所在大厅倍率房间
	V_HALL_ROOM_QUIT_BACK              = 472;
    V_HALL_PROPTYPE_GET                 = 2807;--获取道具基础信息
    V_HALL_PROPGOODS_GET = 2809;--获取商品基础信息
     V_HALL_PROPGOODS_GET_BACK = 2810;--返回商品基础信息
    V_HALL_HUNTER_ROOM_JOIN_GET = 2829;--获取我创建或参与的私人渔场信息
    V_HALL_HUNTER_ROOM_JOIN_GET_BACK = 2830;--获取我创建或参与的私人渔场信息回包
    V_HALL_CREATE_HUNTERROOM_CONFIG = 2832;--创建渔场配置信息
    V_HALL_DIAMONGS_GET=2805;--获取钻石配置信息
    V_HALL_REWARD_GET					= 815;
    V_HALL_REWARD_GET_BACK				= 816;
}
 NETFields=
{

    TIMESTAMP = "timeStamp";
	K_CLIENT_TIME = "clientTime";

	K_ACCOUNT   = "account";
	K_PASSWD    = "password";
	K_DYN_TOKEN = "dynToken";

	K_PID = "productId";
	K_PTOKEN = "clientkey";
    K_MOBILE_TOKEN = "mobileKey";
	K_VERSION = "clientVersion";
	K_USERTYPE = "userType";
    K_USER_TOKEN = "usertoken";
    K_RELOGIN = "relogin";

	K_USER_ID  = "userId";
	K_USER_NAME = "userName";
	K_LOGIN_ID = "loginId";
    K_OPERTYPE = "opertype";
	K_ROOM_ID  = "roomId";
	K_USER_CASH = "cash";
    K_QUERY_TIME = "time";
	
	K_FISHS            = "fishs";
	K_SPAWN_TIME       = "ST";
	K_FISH_TYPE_ID     = "TID";
	K_FISH_SERIAL_ID   = "SID";
	K_FISH_HEALTH      = "LF";
	K_TIME_TO_LIVE     = "TTL";
    K_CURVE            = "CV";
    K_CURVE_3D = "CV3D";
	K_FISH_MATRIX      = "fishMatrix";
	K_NUMS             = "nums";
	K_BL			   = "BL";
    K_FISH_PATHID = "fishPathID";

	K_CBMS 	   = "CBMS";

	K_FIRE_TIME  = "fireTime";
	K_CANNON_TID = "canTID";
	K_BULLET_SID = "BSID";
	K_LINE       = "LN";
	K_MRID		 = "MRID";
	K_LEVER_N	 = "n";
    K_ROBOT_USER = "robotUserId";
    

	K_FISH_LIVE_TIME   = "fishLiveTime";
	K_BULLET_LIVE_TIME = "bulletLiveTime";
	K_FSID             = "FSID";
	K_HIT_FSID_S       = "hitFSIDs";
	K_MISS_FSID_S      = "missFSIDs";
	K_JACKPOT2         = "jackpot2";
	K_CANNON_COST      = "cannonCost";
    K_FISHID = "fishSerialId";

    K_FROM_LOGIN = "fromLogin";
	K_HALL_ANN_LUT				= "lastUpdateTime";
	K_HALL_ANN_INFO	   			= "annInfo";
	K_HALL_ANN_INFO_MSG			= "Msg";
	K_HALL_ANN_INFO_STICK		= "Stick";
	K_HALL_ANN_INFO_UT			= "UpdateTime";
    K_HALL_ANN_INFO_REFRATE = "RefreshRate";
	K_HALL_PLAYER_INFO			= "userInfo";
	K_HALL_PLAYER_INFO_NICK		= "nick";
    K_HALL_PLAYER_INFO_CASH		= "cash";
    K_HALL_PLAYER_INFO_TRYCASH     = "trycash";
	K_HALL_PLAYER_INFO_NAME		= "name";
	K_HALL_ROOM_GROUP			= "roomGroup";
    K_HALL_ROOM_GROUP_INFO = "roomGroupInfo";
    K_HALL_ROOM_GROUP_ONLINE_COUNTLIST = "roomGroupOnlineCountList";
	K_HALL_ROOM_GROUP_ROOMBETX	= "roomBetX";
	K_HALL_ROOM_GROUP_ROOMIDLIST= "roomIdList";
	K_HALL_ROOM_GROUP_GROUPID	= "groupId";
	K_HALL_ROOM_ROOMGROUPID		= "roomGroupId";
	K_HALL_ROOM_ROOMLIST		= "roomList";
	K_HALL_ROOM_ID				= "roomId";
	K_HALL_ROOM_ESN				= "emptySeatNum";


	K_HALL_ROOM_ROOMIDLIST		= "roomIdList";
	K_HALL_ROOM_PLAYERLIST		= "playerList";
	K_HALL_ROOM_SEATID			= "seatId";
	K_HALL_ROOM_USERID			= "userId";
	K_HALL_RANK_INFO			= "top10Info";
	K_HALL_RANK_DATETYPE		= "dataType";
	K_HALL_RANK_SUM				= "Sum";
	 K_HALL_RANK_DATA			= "data";
    K_HALL_GAME_ID = "GameId";
    
	K_HALL_INVEST_UNHUNTED_PAGENUM		= "page";
	K_HALL_INVEST_UNHUNTED_PAGESIZE		= "pageSize";
	K_HALL_INVEST_UNHUNTED_FISHS		= "fishs";
	K_HALL_INVEST_UNHUNTED_ID			= "Id";
	K_HALL_INVEST_UNHUNTED_BEX			= "betX";
    K_HALL_INVEST_UNHUNTED_TYPE			= "type";
	K_HALL_INVEST_UNHUNTED_BULLET		= "bulletEarn";
	K_HALL_INVEST_UNHUNTED_ROOMID		= "roomId";
	K_HALL_INVEST_UNHUNTED_LIFE			= "life";
	K_HALL_INVEST_UNHUNTED_NUM			= "num";
	K_HALL_INVEST_UNHUNTED_HITUSER		= "hitUser";

	K_HALL_ROOM_FISHID			= "fishId";

	K_SCENE_INFO_TYPE			= "type";
	K_SCENE_SCENEID				= "sceneId";
	K_SCENE_BG_IDX              = "clientSceneId";
	K_SCENE_TIMER				= "scenelength";
	K_SCENE_BIG3				= "big3";
	K_SCENE_BIG3_BALANCE		= "balance";
	K_SCENE_BIG3_COST			= "cost";
	K_SCENE_BIG3_EARN			= "earn";
	K_SCENE_BIG3_FISHID			= "fishId";
	K_SCENE_USERS				= "users";
	K_SCENE_USERS_UID			= "uid";
	K_SCENE_USERS_COST			= "cost";
	K_SCENE_USERS_EARN			= "earn";
    K_SCENE_USERS_CASH_COST = "CashCost";
    K_SCENE_USERS_CASH_EARN = "CashEarn";
	K_SCENE_USERS_NAME			= "name";
    K_SCENE_USERS_PHOTOURL = "photourl";

	K_GAME_REWARD  = "GRD";
	K_PLAYER_ACCOUNT  = "PAT";
	K_JPBONUS_ENERGY   = "BON";
    K_ROOM_ENERGY   = "REG";

	K_ROOM_CURRENT	  = "Current";
	K_ROOM_FID		  = "FId";
	K_ROOM_LAST		  = "Last";
	K_BETX = "betX";
    K_BETDIV = "betXDiv";
    K_ROOMTYPE = "roomType";
    K_ROOMSTARTTIME = "tickStartTime";
    
	K_JP1_PRIZE = "bravo";
	K_JP1_LEVEL = "level";
	K_PARTYJP   = "j";

	K_TASK_AWARD = "prize";
	K_TASK_GOAL = "goal";
	K_TASK_PROGRESS = "huntedFish";
	K_TASK_WINNER = "userId";



	-- field in packet from Server
	K_RET = "ret";
	K_MSG = "msg";
    K_KEY = "key";
    K_SHOOTSPEED = "cannonSpeed";

	K_JP1_DRAW_SEQ = "openarray";
	K_JP1_DRAW_LOC = "posarray";
	K_JP1_OPEN_END_FLG = "end";
	K_JP1_OPEN_SHELL_POS = "pos";
	K_JP1_REWARD_NAME = "userName";
	K_JP1_REWARD_LEVEL = "level";
	K_JP1_REWARD_PRIZE = "prize";
}