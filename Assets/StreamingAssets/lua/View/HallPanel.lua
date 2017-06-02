--region *.lua
--Date
--Init by Yangyang 2017-2-20
--此文件由[BabeLua]插件自动生成

local transform;
local gameObject;

HallPanel = {};
local this = HallPanel;

--启动事件--
function HallPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end


--初始化面板--
function HallPanel.InitPanel()
	this.QuickStart = transform:FindChild("Camera/Hall/QuickStart").gameObject;
	this.mask = transform:FindChild("Camera/Panel_Compatible/Curtain").gameObject;	
end
--单击事件--
function HallPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end

--endregion
