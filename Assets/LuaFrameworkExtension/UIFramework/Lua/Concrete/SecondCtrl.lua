require "Common/define"
require "Logic/UIPanelBase"

SecondCtrl = UIPanelBase:New();
local gameObject;
local transform;
local tweener;

function SecondCtrl.New()
	return SecondCtrl;
end

function SecondCtrl.Awake()
	panelMgr:CreatePanel('Second', SecondCtrl.OnCreate);
end

function SecondCtrl.OnCreate(obj)
	gameObject = obj;
    transform = obj.transform;
	SecondCtrl.gameObject = obj;
    SecondCtrl.transform = obj.transform;
	
	local btn1 = transform:FindChild("YesButton"):GetComponent('UIButton');
	local btn2 = transform:FindChild("NoButton"):GetComponent('UIButton');
	
	EventDelegate.Add(btn1.onClick, EventDelegate.Callback(SecondCtrl.CloseFirstPanel));
	EventDelegate.Add(btn2.onClick, EventDelegate.Callback(SecondCtrl.ClosePanel));
	
	SecondCtrl:Open();
end

function SecondCtrl.CloseFirstPanel()
	SecondCtrl:Close();
	CtrlManager.GetCtrl(CtrlNames.First):Close();
end

function SecondCtrl.ClosePanel()
	SecondCtrl:Close();
end