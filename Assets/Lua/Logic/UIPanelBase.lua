UIPanelBase = {	};

function UIPanelBase:New()
	local o = {};	
	setmetatable(o, UIPanelBase);
	UIPanelBase.__index = UIPanelBase;
	return o;
end

function UIPanelBase:Open()
	if(self.gameObject == nil) then
		self:Awake();
	else
		self.gameObject:SetActive(true);
		if(self.tweener ~= nil) then self.tweener:PlayForward(); end
	end	
end

function UIPanelBase:Close()
	if(self.tweener ~= nil) then self.tweener:PlayReverse(); 
	else self.gameObject:SetActive(false); end
end

function UIPanelBase:SetOpenCloseTweener(tweener, list, callBack)
	self.tweener = tweener;
	if((list ~= nil) and (callBack ~= nil)) then EventDelegate.Add(list, EventDelegate.Callback(callBack)); end
end