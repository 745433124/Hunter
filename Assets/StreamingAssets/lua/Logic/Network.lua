
require "Common/define"
require "Common/functions"

require "Common/json"
require "Logic/Constant"
require "Logic/Packing"
require "Logic/InternalEvent"

Event = require 'events'


Network = {};
local this = Network;

local transform;
local gameObject;
local islogging = false;

function Network.Start() 
    logWarn("Network.Start!!");
	--[[
    Event.AddListener(Protocal.Connect, this.OnConnect); 
    Event.AddListener(Protocal.Message, this.OnMessage); 
    Event.AddListener(Protocal.Exception, this.OnException); 
    Event.AddListener(Protocal.Disconnect, this.OnDisconnect); 
	]]--
end

--Socket消息--
--[[
 function Network.OnSocket(key, data)
    Event.Brocast(tostring(key), data);
end
]]--
function Network.OnSocket(data)
    --Event.Brocast(data);
	--log('data:>'..data);
	
	if(data == "Connected") then
		--连接服务器成功
		this.OnConnect()
	elseif(data == "Exception") then
		--异常断线
		this.OnException()
	elseif(data == "Disconnect") then
		--连接中断，或者被踢掉
		this.OnDisconnect()
	else
		--正常消息包
		this.OnMessage(data)
	end
end

local SWITCH_METATABLE = {
	__index = function(t, k)
				return rawget(t, "__default")
			end,
}

function SwitchGenerator(tbl)
	tbl = tbl or {}
	setmetatable(tbl, SWITCH_METATABLE)
	return function(case)
				return tbl[case]()
			end, tbl
end

--当连接建立时--
function Network.OnConnect() 
    logWarn("Game Server connected!!");
	
	Event.Brocast(Evt.NET_STATE_CONNECTED);
end

--异常断线--
function Network.OnException() 
    islogging = false; 
    NetManager:SendConnect();
   	logError("OnException------->>>>");
end

--连接中断，或者被踢掉--
function Network.OnDisconnect() 
    islogging = false; 
    logError("OnDisconnect------->>>>");
    Event.Brocast(Evt.NET_STATE_DISCONNECTED);
end

--消息处理--
function Network.OnMessage(data) 
    
	--解析消息--
	hashtbl = json.decode(data);
	--此处消息分发---   
   -- log(hashtbl[NETOpcodes.KEY])
	this.Distributer(hashtbl[NETOpcodes.KEY]);
end


--分发消息--
function Network.Distributer(key_op)
	local event_table = {
		[NETOpcodes.V_LOGIN_BACK] = do_login,
		[NETOpcodes.V_START_GAME_BACK] = do_startgame,
        [NETOpcodes.V_PING_BACK] = do_sendbackping,
        [NETOpcodes.V_KICK_BACK] = do_sendbackping,
        [NETOpcodes.V_HALL_PLAYER_INFO_GET_BACK]=do_sendbacpplayinfo,
	    [NETOpcodes.V_HALL_FISH_TYPE_GET_BACK]=do_getbackfishtype,
        [NETOpcodes.V_HALL_ROOM_GROUP_LIST_GET_BACK]=do_getbackroomgrouplist,
        [NETOpcodes.V_HALL_ROOM_LIST_GET_BACK]=do_getbackroomlist,
		[NETOpcodes.V_HALL_ROOM_INFO_GET_BACK]=do_getbackroominfo,
	    [NETOpcodes.V_HALL_ROOM_ENTER_BACK]=do_getenterroomback,
		[NETOpcodes.V_HALL_REWARD_GET_BACK]=do_getbackreward,
		[NETOpcodes.V_HALL_RANK_GET_BACK]=do_getbackhallrank,
        [NETOpcodes.V_HALL_DIAMONGS_GET]=do_getbackgetdiamonsbaseInfo,
        [NETOpcodes.V_HALL_PROPTYPE_GET]=do_getbackgetpropIntembaseInfo,
        [NETOpcodes.V_HALL_PROPGOODS_GET]=do_getbackgetgetgoodItemBaseInfo,
        

   

   

		__default = do_default,
	};
	local switch, tbl = SwitchGenerator(event_table);
	switch(key_op);
end

function do_login()
	log("login back");
	
	Event.Brocast(Evt.NET_CMD_LOGIN_BACK, hashtbl);
end

function do_startgame()
	log("startgame back");
	Event.Brocast(Evt.NET_CMD_START_GAME_BACK, hashtbl);
end

function do_sendbackping()
	--log("send ping back");
	Event.Brocast(Evt.NET_CMD_PING_BACK, hashtbl);
end
function do_kickBack()
	--log("send ping back");
	Event.Brocast(Evt.NET_CMD_KICK_BACK, hashtbl);
end
function do_sendbacpplayinfo()
    Event.Brocast(Evt.NET_CMD_HALL_PLAYER_INFO_GET_BACK, hashtbl);
end
function do_getbackfishtype()
 Event.Brocast(Evt.NET_CMD_HALL_FISH_TYPE_GET_BACK,hashtbl);
 end
 function do_getbackroomgrouplist()
 Event.Brocast(Evt.NET_CMD_HALL_ROOM_GROUP_LIST_GET_BACK, tbl);
 end
  function do_getbackroomlist()
  Event.Brocast(Evt.NET_CMD_HALL_ROOM_LIST_GET_BACK, tbl);
 end
 function do_getbackroominfo()
 Event.Brocast(Evt.NET_CMD_HALL_ROOM_INFO_GET_BACK, tbl);	
 end
 function do_getenterroomback()
 Event.Brocast(Evt.NET_CMD_HALL_ROOM_ENTER_BACK, tbl);
 end
  function do_getbackreward()
 Event.Brocast(Evt.NET_CMD_HALL_REWARD_GET_BACK, tbl);
 end
function do_getbackhallrank()
Event.Brocast(Evt.NET_CMD_HALL_RANK_GET_BACK, tbl); 
end	
	--/// <summary>
 --   /// 获取钻石配置
 --   /// </summary>
 --   /// <returns></returns>
  function  do_getbackgetdiamonsbaseInfo()
    Event.Brocast(Evt.CMD_NET_V_HALL_DIAMONGS_GET_BACK, tbl); 
 end

  --/// <summary>
  --  /// 获取道具基础信息配置
  --  /// </summary>
  --  /// <returns></returns>
 function  do_getbackgetpropIntembaseInfo()
    Event.Brocast(Evt.CMD_NET_V_HALL_PROPTYPE_GET_BACK, tbl); 
 end
  function  do_getbackgetgetgoodItemBaseInfo()
    Event.Brocast(Evt.CMD_NET_V_HALL_PROPGOODS_GET_BACK, tbl); 
 end
 
    
function do_default()
	--log("distribute error");
end


---------------------------------------------------

--卸载网络监听--
function Network.Unload()
    --[[Event.RemoveListener(Protocal.Connect);
    Event.RemoveListener(Protocal.Message);
    Event.RemoveListener(Protocal.Exception);
    Event.RemoveListener(Protocal.Disconnect);--]]
    logWarn('Unload Network...');
end