using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;
using System.IO;

public class AutoRegisterUtility : EditorWindow {

    List<string> nameList = new List<string>();
    int capacity = 0;
    string capacityText = "0";

    string defineLuaPath = Application.dataPath + "/LuaFramework/Lua/Common/define.Lua";
    string ctrlManagerLuaPath = Application.dataPath + "/LuaFramework/Lua/Logic/CtrlManager.Lua";
    string gameLuaPath = Application.dataPath + "/LuaFramework/Lua/Logic/Game.Lua";
    string startupPanel = "";

    string targetPanelLuaPath = Application.dataPath + "/LuaFramework/Lua/View/";
    string targetCtrlLuaPath = Application.dataPath + "/LuaFramework/Lua/Controller/";

    //下面两个路径要根据自身情况修改
    string panelLuaPath = @"D:\Program Files\Unity5.3.2\Unity\Editor\Data\Resources\ScriptTemplates\88-ToLua# Panel Script-Panel.lua.txt";
    string ctrlLuaPath = @"D:\Program Files\Unity5.3.2\Unity\Editor\Data\Resources\ScriptTemplates\89-ToLua# Ctrl Script-Ctrl.lua.txt";

    string resourceBuildPath = Application.dataPath + "/LuaFramework/Examples/Builds/";

    [MenuItem("LuaFramework/AutoRegister")]
    static void SetAssetBundleNameExtension()
    {
        EditorWindow.GetWindow<AutoRegisterUtility>();
    }

    void OnGUI()
    {
        EditorGUILayout.BeginHorizontal();

        capacityText = EditorGUILayout.TextField("Panel数量", capacityText);
        if (GUILayout.Button("确定(注：Panel名字无需带有'Panel'字样)"))
        {
            if (!int.TryParse(capacityText, out capacity)) return;

            if (nameList.Count == 0) for (int i = 0; i < capacity; i++) nameList.Add("");
            else if (nameList.Count < capacity) for (int i = nameList.Count; i < capacity; i++) nameList.Add("");
            else if (nameList.Count > capacity) for (int i = nameList.Count; i > capacity; i--) nameList.RemoveAt(i - 1);
        }

        EditorGUILayout.EndHorizontal();

        if (capacity > 0) for (int i = 0; i < capacity; i++) nameList[i] = EditorGUILayout.TextField(i + ".Panel名字:", nameList[i]);


        EditorGUILayout.LabelField("------------------------------------------------------------------");
        EditorGUILayout.LabelField("下面的设置将修改：");
        EditorGUILayout.LabelField("1.define.lua" + " 路径为: " + defineLuaPath);
        EditorGUILayout.LabelField("2.CtrlManager.lua" + " 路径为: " + ctrlManagerLuaPath);
        EditorGUILayout.LabelField("3.Game.lua" + " 路径为: " + gameLuaPath);
        if (GUILayout.Button("修改define.lua 与 CtrlManager.lua"))
        {
            //修改define.lua
            string content = File.ReadAllText(defineLuaPath);//Debug.Log(content);
            for (int i = 0; i < capacity; i++)
            {
                int a = content.IndexOf('}', content.IndexOf("CtrlNames"));
                content = content.Insert(a, "\t" + nameList[i] + " = \"" + nameList[i] + "Ctrl" + "\",\r\n");
                int b = content.IndexOf('}', content.IndexOf("PanelNames"));
                content = content.Insert(b, "\t" + "\"" + nameList[i] + "Panel" + "\",\r\n");
            }
            File.WriteAllText(defineLuaPath, content);

            //修改CtrlManager.lua
            string content2 = File.ReadAllText(ctrlManagerLuaPath);//Debug.Log(content);
            for (int i = 0; i < capacity; i++)
            {
                int a = content2.IndexOf("CtrlManager");
                content2 = content2.Insert(a - 1, "require \"Controller/" + nameList[i] + "Ctrl\"\r\n");
                int b = content2.IndexOf("return");
                content2 = content2.Insert(b, "ctrlList[CtrlNames." + nameList[i] + "] = " + nameList[i] + "Ctrl.New();\r\n\t");
            }
            File.WriteAllText(ctrlManagerLuaPath, content2);

            Debug.Log("修改完毕！");
        }

        EditorGUILayout.BeginHorizontal();
        startupPanel = EditorGUILayout.TextField("将Panel名字为：", startupPanel);
        if (GUILayout.Button("设置为启动Panel(修改Game.lua)"))
        {
            //修改Game.lua
            string content3 = File.ReadAllText(gameLuaPath);
            int a = content3.IndexOf("Game");
            content3 = content3.Insert(a, "require \"Controller/" + startupPanel + "Ctrl\"\r\n");
            int b = content3.IndexOf("local ctrl = CtrlManager.GetCtrl(CtrlNames.") + "local ctrl = CtrlManager.GetCtrl(CtrlNames.".Length;
            int c = content3.IndexOf(')', b);

            content3 = content3.Remove(b, c - b);
            content3 = content3.Insert(b, startupPanel);
            File.WriteAllText(gameLuaPath, content3);
 
            Debug.Log(startupPanel);   
        }
        EditorGUILayout.EndHorizontal();


        EditorGUILayout.LabelField("------------------------------------------------------------------");
        EditorGUILayout.LabelField("lua模板的位置(如不同请修改)：");
        EditorGUILayout.LabelField("XXXPanel.lua" + " 路径为: " + panelLuaPath);
        EditorGUILayout.LabelField("XXXCtrl.lua" + " 路径为: " + ctrlLuaPath);
        if (GUILayout.Button("生成lua文件"))
        {
            for (int i = 0; i < capacity; i++)
            {
                string a = targetPanelLuaPath + nameList[i] + "Panel.lua";
                string b = targetCtrlLuaPath + nameList[i] + "Ctrl.lua";

                if (File.Exists(a)) File.Delete(a);
                if (File.Exists(b)) File.Delete(b);

                FileUtil.CopyFileOrDirectory(panelLuaPath, a);
                FileUtil.CopyFileOrDirectory(ctrlLuaPath, b);

                string contentA = File.ReadAllText(a);
                contentA = contentA.Replace("#SCRIPTNAME#", nameList[i] + "Panel");
                File.WriteAllText(a, contentA);

                string contentB = File.ReadAllText(b);
                contentB = contentB.Replace("#SCRIPTNAME#", nameList[i] + "Ctrl");
                File.WriteAllText(b, contentB);
            }
            AssetDatabase.Refresh();
        }

        if (GUILayout.Button("创建Panel资源文件夹"))
        {
            for (int i = 0; i < capacity; i++)
            {
                Directory.CreateDirectory(resourceBuildPath + nameList[i]);
            }
            AssetDatabase.Refresh();
        }
    }

}
