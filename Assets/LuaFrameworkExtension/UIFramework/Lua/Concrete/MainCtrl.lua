require "Common/define"
require "Logic/UIPanelBase"

MainCtrl = UIPanelBase:New();
local gameObject;
local transform;
local tweener;

function MainCtrl.New()
	return MainCtrl;
end

function MainCtrl.Awake()
	panelMgr:CreatePanel('Main', MainCtrl.OnCreate);
end

function MainCtrl.OnCreate(obj)
	gameObject = obj;
    transform = obj.transform;
	MainCtrl.gameObject = obj;
    MainCtrl.transform = obj.transform;
	
	MainCtrl.hpLabel = transform:FindChild("HpLabel"):GetComponent('UILabel');
	MainCtrl.mpLabel = transform:FindChild("MpLabel"):GetComponent('UILabel');
	
	UIEventListener.Get(transform:FindChild("Button1").gameObject).onClick = MainCtrl.OpenFirstPanel;
	UIEventListener.Get(transform:FindChild("Button2").gameObject).onClick = MainCtrl.OpenThirdPanel;
	
	MainCtrl:Open();
end

function MainCtrl.OpenFirstPanel()
	CtrlManager.GetCtrl(CtrlNames.First):Open();
end

function MainCtrl.OpenThirdPanel()
	CtrlManager.GetCtrl(CtrlNames.Third):Open();
end