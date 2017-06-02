using UnityEngine;
using System.Collections;

public class FirstPanel : UIPanelBase {

    private MainPanel mainPanel;

    protected override void Awake()
    {
        base.Awake();
        UIPanelManager.Instance.CreatePanel(UIPanelName.FirstPanel, OnCreate);
    }

    protected override void OnCreate(GameObject go)
    {
        base.OnCreate(go);
        mainPanel = UIPanelManager.Instance.GetPanel(UIPanelName.MainPanel) as MainPanel;
        TweenScale tweenScale = transform.GetComponent<TweenScale>();
        SetOpenCloseTweener(tweenScale, tweenScale.onFinished, delegate()
        {
            if (tweenScale.direction == AnimationOrTween.Direction.Reverse) gameObject.SetActive(false);
        });
        Open();

        UISlider slider = transform.FindChild("Slider").GetComponent<UISlider>();
        UILabel sliderLabel = slider.transform.FindChild("Label").GetComponent<UILabel>();
        EventDelegate.Add(slider.onChange, delegate() {
            string value = (int)(slider.value * 100) + "";
            sliderLabel.text = value;
            mainPanel.hpLabel.text = value;
        });

        UIPopupList popupList = transform.FindChild("Popup List").GetComponent<UIPopupList>();
        EventDelegate.Add(popupList.onChange, delegate() {
            mainPanel.mpLabel.text = popupList.value;
        });

        UIEventListener.Get(transform.FindChild("CloseButton").gameObject).onClick =
            delegate(GameObject a)
            {
                Close();
            };

        UIEventListener.Get(transform.FindChild("EnsureButton").gameObject).onClick =
            delegate(GameObject a)
            {
                UIPanelManager.Instance.GetPanel(UIPanelName.SecondPanel).Open();
            };
    }

}
