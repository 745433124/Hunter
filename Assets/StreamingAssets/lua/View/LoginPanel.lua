local transform;
local gameObject;

LoginPanel = {};
local this = LoginPanel;
local NoticeText=nil;
local coShowNoticeText=nil;
--启动事件--
function LoginPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end
function this.Start( )
	logWarn("LoginPanel.Start--->>");
end

--初始化面板--
function LoginPanel.InitPanel()
   this.wechatLoginBtn = transform:FindChild('LoginContent/QrLogin').gameObject;
   this.guessLoginBtn = transform:FindChild('LoginContent/TryLogin').gameObject;
   this.ToolTipPanel = transform:FindChild("ToolTipPanel").gameObject;
   this.CompactPanel = transform:FindChild("CompactPanel").gameObject;
   this.Version     =transform:FindChild("Version"):GetComponent('UILabel');
   NoticeText = transform:FindChild("NoticeText").gameObject;
   this.compcatToggle = transform:FindChild('LoginContent/UserCompact/compactCheckBox'):GetComponent('UIToggle');
   this.compcatBtn = transform:FindChild('LoginContent/UserCompact/compactBtn').gameObject;
   this.loginContent = transform:FindChild("LoginContent").gameObject;
end

function LoginPanel.GetcompcatToggleValue()
  return  this.compcatToggle.value;
end
function LoginPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end

function LoginPanel.ShowLoginNotice(text,time)
    time=time or 0;
    coShowNoticeText=coroutine.create(this.ShowLoginNoticeOntime);
     coroutine.resume(coShowNoticeText,text,time);
end
function LoginPanel.ShowLoginNoticeOntime(text,time) 
   if NoticeText == nil then    
        NoticeText = transform:FindChild("NoticeText").gameObject;
    end
    local notice = nil;
       notice = NoticeText.transform.FindChild("Text").gameObject;
    if notice ~= nil then       
       notice:GetComponent('UILabel').text = tostring(text);
       notice.gameObject:SetActive(true);
       NoticeText.SetActive(true);
        if time == 0 then            
             return;           
        else           
            coroutine.wait(time);
            ShowLogin();
            if NoticeText ~= nil then
                NoticeText:SetActive(false);
            end         
        end
    end             
 end
