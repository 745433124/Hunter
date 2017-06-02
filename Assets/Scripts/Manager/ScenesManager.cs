using UnityEngine;
using cn.sharesdk.unity3d;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
namespace LuaFramework
{
    public class ScenesManager : Manager
    {
        private ShareSDK ssdk = null;
        LuaFunction funcAuthrizeResult = null;//向lua回调微信认证结果
        private int _sceneID;
        public int CurrentSceneID
        {
            private set
            {
                _sceneID = value;
            }
            get
            {
                return _sceneID;
            }
        }
        void Start()
        {
            _sceneID = UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex;

            //if (ssdk == null)
            //{
            //    ssdk = gameObject.AddComponent<ShareSDK>();
            //    ssdk.enabled = true;
            //    ssdk.authHandler = OnAuthResultHandler;
            //    ssdk.showUserHandler = OnGetUserInfoResultHandler;
            //}
        }
        
 
        /// <summary>
        /// 销毁资源
        /// </summary>
        void OnDestroy()
        {
            Debug.Log("~ScenesManager was destroy!");
        }

        public void ShareSDKInit(string appID, string appKey, string appSecret, LuaFunction func)
        {
            if (ssdk == null)
            {
                ssdk = gameObject.GetComponent<ShareSDK>();
                ssdk.authHandler = OnAuthResultHandler;
                ssdk.showUserHandler = OnGetUserInfoResultHandler;
            }
            ssdk.appKey = appID;
            DevInfoSet dev = ssdk.devInfo;
            dev.wechat.Enable = true;
            dev.wechat.AppId = appKey;
            dev.wechat.SortId = "5";
            dev.wechat.AppSecret = appSecret;
            dev.wechat.BypassApproval = false;

            dev.wechatMoments.Enable = true;
            dev.wechat.SortId = "6";
            dev.wechatMoments.AppId = appKey;
            dev.wechatMoments.AppSecret = appSecret;
            dev.wechatMoments.BypassApproval = false;

            dev.wechatFavorites.Enable = true;
            dev.wechat.SortId = "7";
            dev.wechatFavorites.AppId = appKey;
            dev.wechatFavorites.AppSecret = appSecret;
            ssdk.devInfo = dev;
            funcAuthrizeResult = func;
            ssdk.Authorize(PlatformType.WeChat);//同时启动微信认证
        }

        private void OnGetUserInfoResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
        {
            if (state == ResponseState.Success)
            {
                Debug.Log("OnGetUserInfoResultHandler Start");
                if (result != null)
                {
                    HandleUserInfo(result, type);
                    //  StartCoroutine(HandleAuthFromShareSDK());
                    //  HideAllLoginBtns(true);
                }

            }
            else if (state == ResponseState.Fail)
            {
#if UNITY_ANDROID
                Debug.Log("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IOS
            Debug.Log ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
               if (funcAuthrizeResult != null)
                    funcAuthrizeResult.Call(ResponseState.Fail);
            }
            else if (state == ResponseState.Cancel)
            {
               if (funcAuthrizeResult != null)
                    funcAuthrizeResult.Call(ResponseState.Cancel);
                Debug.Log("cancel !");
            }
        }
        private void OnAuthResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
        {
            if (state == ResponseState.Success)
            {
                Debug.Log(result);
                ssdk.GetUserInfo(type);

            }
            else if (state == ResponseState.Fail)
            {
#if UNITY_ANDROID
                Debug.Log("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IOS
			Debug.Log ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
                Debug.Log("Authorize Error");
                Debug.Log("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
                if (funcAuthrizeResult != null)
                    funcAuthrizeResult.Call(ResponseState.Fail);
                //ShowLogin();
                //_bWechartLogining = false;
            }
            else if (state == ResponseState.Cancel)
            {
                Debug.Log("cancel !");
                Debug.Log("Authorize cancel");
                if (funcAuthrizeResult != null)
                    funcAuthrizeResult.Call(ResponseState.Cancel);
                //ShowLogin();
                //_bWechartLogining = false;
            }

        }
        void HandleUserInfo(Hashtable result, PlatformType type)
        {
            string _userOpenID = "";
            string _userUnionID = "";
            string _userIcon = "";
            string _userNickName = "";              
            switch (type)
            {
                case PlatformType.WeChat:
                     Debug.Log(result);                   
                    if (result.ContainsKey("openid"))
                    {
                        _userOpenID = result["openid"].ToString();
                        PlayerPrefs.SetString("LoginWeChart openID", _userOpenID);
                        Debug.Log("Config.weChatAccessOpenID:" + _userOpenID);

                    }
                    if (result.ContainsKey("unionid"))
                    {
                        _userUnionID = result["unionid"].ToString();
                        PlayerPrefs.SetString("LoginWeChart unionid", _userUnionID);
                        Debug.Log("Config.weChatAccessOUnionID:" + _userUnionID);

                    }
                    if (result.ContainsKey("headimgurl"))
                    {
                        if (result["headimgurl"] != null)
                            _userIcon = result["headimgurl"].ToString();
                        else
                            _userIcon = "";
                        if (!string.IsNullOrEmpty(_userIcon) && _userIcon.Length >= 4)
                        {
                            _userIcon = _userIcon.Insert(4, "s");//  http://**** 改成https://
                        }
                        PlayerPrefs.SetString("LoginWeChart userIcon", _userIcon);
                        Debug.Log("LoginView : weChatUserIconUrl=" + _userIcon);

                    }

                    if (result.ContainsKey("nickname"))
                    {
                        _userNickName = result["nickname"].ToString();
                        PlayerPrefs.SetString("LoginWeChart userName", _userNickName);
                        Debug.Log("LoginView : weChatNickName=" + _userNickName);
                    }
                    if (funcAuthrizeResult != null)
                        funcAuthrizeResult.Call(ResponseState.Success,_userOpenID, _userUnionID, _userIcon, _userNickName );
                    break;
            }

        }
        private  IEnumerator LoadAsyScene(int SceneID, LuaFunction func = null)
        {
            Debug.Log("LoadScene######2>>>>" + SceneID);
            AsyncOperation async = Application.LoadLevelAsync(SceneID);
            //读取完毕后返回，系统进入新场景
            yield return async;
            //通知lua函数加载完毕
            if (func != null) func.Call(SceneID);
            Debug.Log("LoadScene------>>>>" + SceneID);
        }
        public void AsyncLoadScene(int SceneID, LuaFunction func = null)
        {
            Debug.Log("LoadScene######1>>>>" + SceneID);
            StartCoroutine(LoadAsyScene(SceneID, func));
        }
    }

       
}
