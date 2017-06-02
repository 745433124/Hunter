require "Common/define"
require "Logic/UIPanelBase"

ThirdCtrl = UIPanelBase:New();
local gameObject;
local transform;
local tweener;
local tweenPosition;

function ThirdCtrl.New()
	return ThirdCtrl;
end

function ThirdCtrl.Awake()
	panelMgr:CreatePanel('Third', ThirdCtrl.OnCreate);
end

function ThirdCtrl.OnCreate(obj)
	gameObject = obj;
	transform = obj.transform;
	ThirdCtrl.gameObject = obj;
	ThirdCtrl.transform = obj.transform;

	tweenPosition = transform:GetComponent('TweenPosition');
    ThirdCtrl:SetOpenCloseTweener(tweenPosition, tweenPosition.onFinished, ThirdCtrl.SetTweener);
	
	local button = transform:FindChild("CloseButton"):GetComponent('UIButton');
	EventDelegate.Add(button.onClick, EventDelegate.Callback(ThirdCtrl.ClosePanel));
	
	ThirdCtrl:Open();
end

function ThirdCtrl.SetTweener()
	if (tweenPosition.direction == AnimationOrTween.Direction.Reverse) then gameObject:SetActive(false); end
end

function ThirdCtrl.ClosePanel()
	ThirdCtrl:Close();
end