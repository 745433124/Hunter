
CtrlNames = {
	Login = "LoginCtrl",
	Message = "MessageCtrl",
    Hall = "HallCtrl"
}
CtrlLogicNames=
{
    SendPing="PingCtrl",
    Main="GameMain",
}
PanelNames = {
	LoginPanel="LoginPanel",	
	MessagePanel="MessagePanel",
    HallPanel="HallPanel",
}



Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();
scenesMgr=LuaHelper.GetScenesManager();
WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;
PlayerPrefs=UnityEngine.PlayerPrefs;