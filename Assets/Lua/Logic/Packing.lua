--[[
 * File Name: Packing.cs
 * Description: define packing message and send to server
 * Revisions:
 * ---------------------------------------
 *    Date     Author    Description
 * ---------------------------------------
 * 2016-10-17  tabe      Initial version
 * 
 * 
 ]]--


json_Instance = require('Common/json')
require "Logic/Constant"

Packing = {};
local this = Packing;

--//-------心跳包------------
function Packing.Ping()
	
    local tbl = {};
	tbl[NETOpcodes.KEY] = NETOpcodes.V_PING;
	--log("-----send ping-----");
	local pingData = json.encode(tbl);   
	networkMgr:SendMessage(pingData);	
end

--//-------登陆请求------------
function Packing.Login_Server(account, passwd, pid)

    local tbl = {};

    tbl[NETOpcodes.KEY] = NETOpcodes.V_LOGIN;

    tbl["productId"] = pid;
	tbl["account"] = account;
	tbl["password"] = passwd;
	tbl["clientVersion"] = "v2.0";

	local loginData = json.encode(tbl);
	log("loginData:"..loginData);

	networkMgr:SendMessage(loginData);
end
--//-------登陆请求------------
function Packing.Login(account,  passwd,  pid,  pidtoken,  bReConnect, bRelogin,mobileToken)
	  
		local tbl = {};
        mobileToken=mobileToken or "";
        bRelogin=bRelogin or 0;
		tbl[NETFields.K_PID] = pid;

		tbl [NETFields.K_PTOKEN] = pidtoken;

		tbl [NETOpcodes.KEY] = NETOpcodes.V_LOGIN;
		tbl [NETFields.K_ACCOUNT] = account;
        
        if bReConnect==false then
          tbl[NETFields.K_DYN_TOKEN] = passwd;
        else
          tbl[NETFields.K_PASSWD] = passwd;
        end
        tbl[NETFields.K_VERSION] = config.communicationVersion;
        	log("send login game: mobileToken"..mobileToken.."bRelogin:"..tostring(bRelogin));
        if bRelogin ~= 0 then
        
            tbl[NETFields.K_RELOGIN] = 2;
        end

        log("send login game: account:" .. account .. ",passwd:".. passwd  .. ",pid:" .. pid .. ",pidtoken:" .. pidtoken);
		local loginData = json.encode(tbl);
	    log("loginData:"..loginData);
	    networkMgr:SendMessage(loginData);
	end
--退出已登录的账号，
 function Packing.LoginOut()    
        local tbl ={};
        tbl[NETOpcodes.KEY] = NETOpcodes.V_LOGIN_OUT;
        local loginData = json.encode(tbl);
	    log("loginData:"..loginData);
	    networkMgr:SendMessage(loginData);
end

--//-------登录成功后，准备进入大厅请求开启游戏逻辑------------
function Packing.StartGame(userId, loginId, roomId)

		roomId = roomId or 1;

        local tbl = {};

		tbl[NETOpcodes.KEY] = NETOpcodes.V_START_GAME;

        tbl["userId"] = userId;
        tbl["loginId"] = loginId;
        tbl["roomId"] = roomId;
        tbl["opertype"] = 1;

        local startgameData = json.encode(tbl);
		log("startgameData:"..startgameData);
		
        networkMgr:SendMessage(startgameData);
end
    --返回大厅
function Packing.BackEnterHall(bChangeRoom)	
		local tbl = {};
		tbl[NETOpcodes.KEY] = NETOpcodes.V_HALL_ENTER;
		tbl[NETFields.K_FROM_LOGIN] = 0;
        tbl["changeroom"] = bChangeRoom;
		local EnterHallData = json.encode(tbl);
		log("startgameData:"..EnterHallData);		
        networkMgr:SendMessage(EnterHallData);	
end
    --[[
    /// <summary>
    /// 获取大厅信息请求
    /// </summary>
    --]]
function Packing.GetHallInfo()   
        local tbl = {};
        tbl[NETOpcodes.KEY] = NETOpcodes.V_HALL_INFO_GET;
        local tblGetHallInfo = json.encode(tbl);	
        networkMgr:SendMessage(tblGetHallInfo);	
        log("Send Get HallInfo.");
end 
   --[[
    /// <summary>
    /// 普通进入房间请求
    /// </summary>
    --]]
	
	function Packing.EnterRoom( userId,  roomId,  seatId, gameId)	
		local tbl = {};
        gameId = gameId or 0;
		tbl[NETOpcodes.KEY] = NETOpcodes.V_HALL_ROOM_ENTER;
		tbl[NETFields.K_USER_ID] = userId;
		tbl[NETFields.K_HALL_ROOM_ID] = roomId;
		tbl[NETFields.K_HALL_ROOM_SEATID] = seatId;
        tbl[NETFields.K_HALL_GAME_ID] = gameId;
        local tblEnterRoom = json.encode(tbl);	
        log("tblEnterRoomData:"..tblEnterRoom);
        networkMgr:SendMessage(tblEnterRoom);	
    end
   --[[
    /// <summary>
    /// 快速进入房间请求
    /// </summary>
    --]]
function Packing.FastEnterRoom( userId,  roomGroupId)
    
        local tbl = {};
        tbl[NETOpcodes.KEY] = NETOpcodes.V_HALL_ROOM_FAST_ENTER;
        tbl[NETFields.K_USER_ID] = userId;
        tbl[NETFields.K_HALL_ROOM_ROOMGROUPID] = roomGroupId;
        log("Send FastEnterRoom.");
        local tblGetHallInfo = json.encode(tbl);	
        networkMgr:SendMessage(tblGetHallInfo);	    
end
