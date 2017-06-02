
Evt = {
    NET_STATE_CONNECTED = "NET_STATE_CONNECTED",                         					--成功连上服务器
    NET_STATE_DISCONNECTED = "NET_STATE_DISCONNECTED",                      				--断开与服务器的连接

    NET_CMD_PING_BACK = "NET_CMD_PING_BACK",                           						--心跳回包
    NET_CMD_LOGIN_BACK = "NET_CMD_LOGIN_BACK",                          					--登陆回包
    NET_CMD_START_GAME_BACK = "NET_CMD_START_GAME_BACK",                     				--登陆后首次进入大厅
    NET_CMD_KICK_BACK = "NET_CMD_KICK_BACK",                                                  --被系统踢出
    --------大厅消息 start-------
    NET_CMD_HALL_PLAYER_INFO_GET_BACK = "NET_CMD_HALL_PLAYER_INFO_GET_BACK",           		--玩家信息
    NET_CMD_HALL_ROOM_GROUP_LIST_GET_BACK = "NET_CMD_HALL_ROOM_GROUP_LIST_GET_BACK",       	--大厅房间列表
    NET_CMD_HALL_FISH_TYPE_GET_BACK = "NET_CMD_HALL_FISH_TYPE_GET_BACK",
    NET_CMD_HALL_ROOM_ENTER_BACK = "NET_CMD_HALL_ROOM_ENTER_BACK",                			--进入房间回包
    CMD_NET_V_HALL_DIAMONGS_GET_BACK=" CMD_NET_V_HALL_DIAMONGS_GET_BACK",--返回钻石配置信息

    CMD_NET_V_HALL_PROPTYPE_GET_BACK="CMD_NET_V_HALL_PROPTYPE_GET_BACK",--返回道具基础信息
    CMD_NET_V_HALL_PROPGOODS_GET_BACK="CMD_NET_V_HALL_PROPGOODS_GET_BACK",--返回商品基础信息
    NET_CMD_HALL_RANK_GET_BACK="NET_CMD_HALL_RANK_GET_BACK",
    NET_CMD_HALL_ROOM_LIST_GET_BACK="NET_CMD_HALL_ROOM_LIST_GET_BACK",
    --------大厅消息 end---------

    --------房间消息 start-------

    NET_CMD_PUSH_SCENE_INFO = "NET_CMD_PUSH_SCENE_INFO",                    				--场景信息

    CMD_SHOOT_BACK = "CMD_SHOOT_BACK",                             							--射击事件
    
    --------房间消息 end---------

    MAX
}