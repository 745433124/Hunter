require "Common/define"
require "Logic/InternalEvent"
require "Logic/Packing"
PingCtrl = {};
local this = PingCtrl;
local  Time=UnityEngine.Time;
local IsRunning = false;
local recvPacketTimeout = 15;--收到回报超时时间
local sendPingPacketTimeout=8;--发包超时时间
local recvPacketTimer = 0;--ping包收包计时
local  pingCoolDuration = 3;--ping包发送冷却总间隔时间
local  pingCount = 0;--ping包发送冷却总间隔时间
local sendPacketTime = 0;--ping包发送计时冷却时间
--构建函数--
function PingCtrl.New()
	logWarn("PingCtrl.New--->>");
	return this;
end

function this.Start( )
	logWarn("PingCtrl.Start--->>");
end

function PingCtrl.Awake()
	logWarn("PingCtrl.Awake--->>");
	
	Event.AddListener(Evt.NET_STATE_CONNECTED, this.OnConnect);
	Event.AddListener(Evt.NET_STATE_DISCONNECTED, this.OnDisConnect);
	Event.AddListener(Evt.NET_CMD_PING_BACK, this.OnPingBack);
	
	--tolua提供UpdateBeat对象，只需添加回调函数，该函数便会每帧执行
	--tolua还提供LateUpdateBeat和FixedUpdateBeat对应于Monobehaviour的LateUpdate和FixedUpdate
	UpdateBeat:Add(this.Update, self);
end

--相当于Monobehaviour的Update方法
function PingCtrl.Update()
	if IsRunning==true then
		recvPacketTimer =recvPacketTimer+ Time.deltaTime;
		if recvPacketTimer > sendPingPacketTimeout then		
			if pingCount <= 0 then
			
				pingCount = pingCoolDuration;
				this.SendPing();
		        -- log("------sendPing ------- " .. Time.timeSinceLevelLoad);
			else			
				pingCount =pingCount- Time.deltaTime;
            end
        end
							
		if recvPacketTimer > recvPacketTimeout then
		
            log("------ recvPk timeout -------");
           -- ReconnectTips.Instance.bShowReconnect = true;
            this.Disconnect();
			return;
		end
	end
end
--开始发送心跳包
function PingCtrl.OnConnect()
    log("received PingCtrl NET_STATE_CONNECTED");
	IsRunning = true;
	this.StartSendPing();
end

function PingCtrl.OnDisConnect()
  log("received NET_STATE_DisCONNECTED");
    IsRunning=false;
	this.DisConnect();
end

function PingCtrl.OnPingBack()
   -- log("received NET_CMD_PING_BACK");
    IsRunning=true;
	this.Reset();
end

--开始调用心跳包发送接口
function PingCtrl.StartSendPing()
	--InvokeRepeating("SendPing", 0, 5);
    this.Reset();
end

--调用发送心跳包
function PingCtrl.SendPing()
	Packing.Ping();
end

--断线处理
function PingCtrl.DisConnect()
	--StopPing();
     IsRunning=false;
     networkMgr:Close();
end

--断开时调用，停止发送心跳包
function PingCtrl.StopPing()
	--CancelInvoke("SendPing");
end

function PingCtrl.Reset()
    recvPacketTimer = 0;
   -- sendPacketTime = 0;
    pingCount=0;
end