using UnityEngine;
using System.Collections.Generic;

public abstract class UIPanelBase {

    public GameObject gameObject;
    public Transform transform;
    protected UITweener tweener;

    protected virtual void Awake()
    {
    }

    protected virtual void OnCreate(GameObject go)
    {
        gameObject = go;
        transform = gameObject.transform;
    }

    protected virtual void OnDestroy()
    {
    }

    public virtual void Open()
    {
        if (gameObject == null)
        {
            Awake();
        }
        else
        {
            gameObject.SetActive(true);//播放动画的前提是Panel具有可见性
            if (tweener != null) tweener.PlayForward();
        }
    }

    public virtual void Close()
    {
        if (tweener != null) tweener.PlayReverse();
        else gameObject.SetActive(false);
    }

    protected virtual void SetOpenCloseTweener(UITweener tweener, List<EventDelegate> list, EventDelegate.Callback callBack)
    {
        this.tweener = tweener;
        if((list != null) && (callBack != null)) EventDelegate.Add(list, callBack);
    }

    public virtual void Refresh()
    { 
    }

}
