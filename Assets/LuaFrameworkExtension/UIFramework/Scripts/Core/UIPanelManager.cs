using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;

public class UIPanelManager : MonoSingletion<UIPanelManager> {

    private const string UIROOT_NAME = "UI Root";
    private Transform rootTra;
    //private Stack<UIPanelBase> panelStack = new Stack<UIPanelBase>();//当前展示的panel
    private Dictionary<string, UIPanelBase> namePanel = new Dictionary<string, UIPanelBase>();//当前场景所有的panel

    private int panelDepth = 0;

    void Awake ()
    {
        new UIPanelConfigure();
    }

	void Start () 
    {
	
	}
	
    public void CreatePanel(string name, Action<GameObject> action)
    {
        GameObject go = Instantiate(Resources.Load<GameObject>(name));
        if (rootTra == null) rootTra = GameObject.Find(UIROOT_NAME).transform;
        go.transform.SetParent(rootTra);
        go.transform.localScale = Vector3.one;

        UIPanel panel = go.GetComponent<UIPanel>();
        if (panel != null)
        {
            panel.depth = panelDepth;
            panelDepth++;
        } 

        action(go);
    }

    public UIPanelBase GetPanel(string name)
    {
        return namePanel[name];
    }

    public void AddPanel(string name, UIPanelBase panel)
    {
        namePanel.Add(name, panel);
    }

    public void RemovePanel(string name, UIPanelBase panel)
    {
        namePanel.Remove(name);
    }

    //当进入下一场景时，要清空
    public void RemovePanelAll()
    {
    }

    public void ClosePanelAll()
    {

    }

}
