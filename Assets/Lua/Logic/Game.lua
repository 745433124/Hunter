
require "Common/define"
require "Common/functions"
require "Common/word"

require "Logic/LuaClass"
require "Logic/CtrlManager"

require "Controller/LoginCtrl"

--管理器--
Game = {};
local this = Game;

local game; 
local transform;
local gameObject;
local WWW = UnityEngine.WWW;

function Game.InitViewPanels()
	--for i = 1, #PanelNames do
    require("View/"..tostring(PanelNames.LoginPanel))
		--require ("View/"..tostring(PanelNames[i]))
	--end
end

--初始化完成，发送链接服务器信息--
function Game.OnInitOK()

    --注册LuaView--
    this.InitViewPanels();

    CtrlManager.Init();
    local ctrl = CtrlManager.GetCtrl(CtrlNames.Login);
    if ctrl ~= nil and AppConst.ExampleMode == 0 then
        ctrl:Awake();
    end
    log('LuaFramework InitOK--->>>');
end

--销毁--
function Game.OnDestroy()
	logWarn('OnDestroy--->>>');
end
