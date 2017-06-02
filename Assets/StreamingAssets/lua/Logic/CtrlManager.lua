require "Common/define"
require "Controller/LoginCtrl"
require "Controller/MessageCtrl"
require "Controller/HallCtrl"
require "Logic/PingCtrl"
require "Logic/GameMain"
CtrlManager = {};
local this = CtrlManager;
local ctrlList = {};	--控制器列表--
local ctrlLogicList = {};	--逻辑控制器列表--

function CtrlManager.Init()
	logWarn("CtrlManager.Init----->>>");
	ctrlList[CtrlNames.Login] = LoginCtrl.New();
	ctrlList[CtrlNames.Message] = MessageCtrl.New();
    ctrlList[CtrlNames.Hall] = HallCtrl.New(); --暂时放在这里初始化
    ctrlLogicList[CtrlLogicNames.Main]=GameMain.New();
    ctrlLogicList[CtrlLogicNames.SendPing] =PingCtrl.New();	--逻辑控制器列表--
	return this;
end

--添加控制器--
function CtrlManager.AddCtrl(ctrlName, ctrlObj)
	ctrlList[ctrlName] = ctrlObj;
end

--获取控制器--
function CtrlManager.GetCtrl(ctrlName)
	return ctrlList[ctrlName];
end

--获取逻辑控制器--
function CtrlManager.GetLogicCtrl(ctrlName)
	return ctrlLogicList[ctrlName];
end

--移除控制器--
function CtrlManager.RemoveCtrl(ctrlName)
	ctrlList[ctrlName] = nil;
end

--关闭控制器--
function CtrlManager.Close()
	logWarn('CtrlManager.Close---->>>');
end