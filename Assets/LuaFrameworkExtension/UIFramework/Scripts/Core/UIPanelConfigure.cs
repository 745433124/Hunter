public class UIPanelName
{
    public const string MainPanel = "MainPanel";
    public const string FirstPanel = "FirstPanel";
    public const string SecondPanel = "SecondPanel";
    public const string ThirdPanel = "ThirdPanel";
}

public class UIPanelConfigure {

    public UIPanelConfigure()
    {
        UIPanelManager.Instance.AddPanel(UIPanelName.MainPanel, new MainPanel());
        UIPanelManager.Instance.AddPanel(UIPanelName.FirstPanel, new FirstPanel());
        UIPanelManager.Instance.AddPanel(UIPanelName.SecondPanel, new SecondPanel());
        UIPanelManager.Instance.AddPanel(UIPanelName.ThirdPanel, new ThirdPanel());

        UIPanelManager.Instance.GetPanel(UIPanelName.MainPanel).Open();
    }

}
