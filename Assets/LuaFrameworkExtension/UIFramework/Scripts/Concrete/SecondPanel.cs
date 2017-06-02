using UnityEngine;
using System.Collections;

public class SecondPanel : UIPanelBase {

    protected override void Awake()
    {
        base.Awake();
        UIPanelManager.Instance.CreatePanel(UIPanelName.SecondPanel, OnCreate);
    }

    protected override void OnCreate(GameObject go)
    {
        base.OnCreate(go);

        EventDelegate.Add(transform.FindChild("YesButton").GetComponent<UIButton>().onClick,
            delegate()
            {
                Close();
                UIPanelManager.Instance.GetPanel(UIPanelName.FirstPanel).Close();
            });

        EventDelegate.Add(transform.FindChild("NoButton").GetComponent<UIButton>().onClick,
            delegate()
            {
                Close();
            });
    }
}
