using UnityEngine;
using System.Collections;

public class ThirdPanel : UIPanelBase {

	protected override void Awake()
    {
        base.Awake();
        UIPanelManager.Instance.CreatePanel(UIPanelName.ThirdPanel, OnCreate);
    }

    protected override void OnCreate(GameObject go)
    {
        base.OnCreate(go);
        TweenPosition tweenPosition = transform.GetComponent<TweenPosition>();
        SetOpenCloseTweener(tweenPosition, tweenPosition.onFinished, delegate()
        {
            if (tweenPosition.direction == AnimationOrTween.Direction.Reverse) gameObject.SetActive(false);
        });
        Open();
        
        UIButton button = transform.FindChild("CloseButton").GetComponent<UIButton>();
        EventDelegate.Add(button.onClick, delegate()
        {
            Close();
        });
    }
}
