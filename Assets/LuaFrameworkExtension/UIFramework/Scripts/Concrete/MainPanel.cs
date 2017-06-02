using UnityEngine;
using System.Collections;

public class MainPanel : UIPanelBase {

    public UILabel hpLabel;
    public UILabel mpLabel;

    protected override void Awake()
    {
        base.Awake();
        UIPanelManager.Instance.CreatePanel(UIPanelName.MainPanel, OnCreate);
    }

    protected override void OnCreate(GameObject go)
    {
        base.OnCreate(go);

        hpLabel = transform.FindChild("HpLabel").GetComponent<UILabel>();
        mpLabel = transform.FindChild("MpLabel").GetComponent<UILabel>();

        UIEventListener.Get(transform.FindChild("Button1").gameObject).onClick = 
            delegate(GameObject a) {
                UIPanelManager.Instance.GetPanel(UIPanelName.FirstPanel).Open();
        };

        UIEventListener.Get(transform.FindChild("Button2").gameObject).onClick =
            delegate(GameObject a)
            {
                UIPanelManager.Instance.GetPanel(UIPanelName.ThirdPanel).Open();
            };
    }

}
