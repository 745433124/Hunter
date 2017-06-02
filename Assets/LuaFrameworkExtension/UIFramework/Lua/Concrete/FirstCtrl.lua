require "Common/define"
require "Logic/UIPanelBase"

FirstCtrl = UIPanelBase:New();
local gameObject;
local transform;
local tweener;

local tweenScale;
local slider;
local sliderLabel;
local popupList;

function FirstCtrl.New()
	return FirstCtrl;
end

function FirstCtrl.Awake()
	panelMgr:CreatePanel('First', FirstCtrl.OnCreate);
end

function FirstCtrl.OnCreate(obj)
	gameObject = obj;
    transform = obj.transform;
	FirstCtrl.gameObject = obj;
    FirstCtrl.transform = obj.transform;
	
	tweenScale = transform:GetComponent('TweenScale');
    FirstCtrl:SetOpenCloseTweener(tweenScale, tweenScale.onFinished, FirstCtrl.SetTweener);
    
	slider = transform:FindChild("Slider"):GetComponent('UISlider');
    sliderLabel = slider.transform:FindChild("Label"):GetComponent('UILabel');
	EventDelegate.Add(slider.onChange, EventDelegate.Callback(FirstCtrl.SliderChange));
	
	popupList = transform:FindChild("Popup List"):GetComponent('UIPopupList');
	EventDelegate.Add(popupList.onChange, EventDelegate.Callback(FirstCtrl.PopupListChange));
		
	UIEventListener.Get(transform:FindChild("CloseButton").gameObject).onClick = FirstCtrl.ClosePanel;		
	UIEventListener.Get(transform:FindChild("EnsureButton").gameObject).onClick = FirstCtrl.OpenSecondPanel;	
	
	FirstCtrl:Open();	
end

function FirstCtrl.SetTweener()
	if (tweenScale.direction == AnimationOrTween.Direction.Reverse) then gameObject:SetActive(false); end
end

function FirstCtrl.SliderChange()
	value = tostring(math.floor(slider.value * 100));
    sliderLabel.text = value;
	CtrlManager.GetCtrl(CtrlNames.Main).hpLabel.text = value;
end

function FirstCtrl.PopupListChange()
	CtrlManager.GetCtrl(CtrlNames.Main).mpLabel.text = popupList.value;
end

function FirstCtrl.ClosePanel()
	FirstCtrl:Close();
end

function FirstCtrl.OpenSecondPanel()
	CtrlManager.GetCtrl(CtrlNames.Second):Open();
end