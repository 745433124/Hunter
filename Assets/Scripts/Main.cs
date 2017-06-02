using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;
namespace LuaFramework {
    /// <summary>
    /// 框架主入口
    /// </summary>
    public class Main : MonoBehaviour {

        void Start() {
            AppFacade.Instance.StartUp();   //启动游戏
            SceneManager.sceneLoaded += OnSceneLoaded;
        }
        void OnApplicationQuit()
        {
            
        }
        void OnSceneLoaded(Scene scence, LoadSceneMode mod)
        {
            int level = scence.buildIndex;
            Util.CallMethod("GameMain", "OnLevelWasLoaded", level);
            Debug.Log("level:" + level);
        }
    }
}