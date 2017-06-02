using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BouteryTest : MonoBehaviour
{
    Transform rootTransform = null;
    UILabel roomInfo = null;
    UIButton backHallBtn = null;
    UIButton ruleBtn = null;
    GameObject shareContentObj = null;
    UIButton shareBtn = null;
    GameObject mySelfInfoeObjct = null;
    GameObject opponentInfoObject = null;
    Vector3 keyNumBoardPos = new Vector3(312, 0, 0);
    GameObject _loading = null;

    bool isCanClick = true;
    float currentTime = 0;
    bool isChooseFinish = false;
    bool opponentIsChooseFinish = false;

    GameObject chooseTopicStep = null;
    UIButton createTopicBtn = null;
    UIButton requestTopicBtn = null;

    GameObject creatTopicStep = null;
    UILabel createTopicValueLable = null;
    UILabel createTopicTipLable = null;
    UIButton createTopicInputBtn = null;
    GameObject creatTopicStepTip = null;

    GameObject requestTopic = null;
    GameObject[] errorTips = null;
    int errorTipCount = 4;
    GameObject requestBigNumTemple = null;
    GameObject requestSmallNumTemple = null;
    Transform requestTopicNumParent = null;
    GameObject[] requestTopicNums = null;
    Vector2 bigNumPos = new Vector2(80, 4);
    Vector2 smallNumPos = new Vector2(55, 4);

    GameObject requestTopicOnLook = null;
    GameObject[] errorTipsOnLook = null;
    GameObject requestBigNumTempleOnLook = null;
    GameObject requestSmallNumTempleOnLook = null;
    Transform requestTopicNumParentOnLook = null;
    GameObject[] requestTopicNumsOnLook = null;
    Transform questionTopicNumParentOnLook = null;
    GameObject[] questionTopicNumsOnLook = null;

    public int length = 1;
    public List<int> topWidths;
    public List<int> bottomWidths;

    void Start()
    {
        LevelInit();
        
    }


    void LevelInit()
    {
        if (rootTransform == null)
        {
            rootTransform = GameObject.Find("UI Root").transform;

            mySelfInfoeObjct = rootTransform.FindChild("UI/PlayerInfo/player1").gameObject;
            mySelfInfoeObjct.gameObject.SetActive(true);
            opponentInfoObject = rootTransform.FindChild("UI/PlayerInfo/player2").gameObject;
            roomInfo = rootTransform.transform.FindChild("UI/RoomInfo/roomNum").GetComponent<UILabel>();
            opponentInfoObject.gameObject.SetActive(false);
            backHallBtn = rootTransform.transform.FindChild("UI/BackHallBtn").GetComponent<UIButton>();
            ruleBtn = rootTransform.transform.FindChild("UI/ruleBtn").GetComponent<UIButton>();

            shareContentObj = rootTransform.transform.FindChild("UI/Share").gameObject;
            shareContentObj.gameObject.SetActive(false);
            shareBtn = shareContentObj.transform.FindChild("ShareBtn").GetComponent<UIButton>();

            chooseTopicStep = rootTransform.transform.FindChild("UI/ChooseTopicStep").gameObject;
            createTopicBtn = chooseTopicStep.transform.FindChild("assignTopic").GetComponent<UIButton>();
            requestTopicBtn = chooseTopicStep.transform.FindChild("requestTopic").GetComponent<UIButton>();
            chooseTopicStep.gameObject.SetActive(false);

            InitCreateTopicStep();
        }
        isChooseFinish = false;
        opponentIsChooseFinish = false;
    }

    void InitCreateTopicStep()
    {
        creatTopicStep = rootTransform.FindChild("UI/CreateTopicer/creatTopicStep").gameObject;
        createTopicInputBtn = creatTopicStep.transform.FindChild("InputBtn").GetComponent<UIButton>();
        createTopicInputBtn.onClick.Clear();
        creatTopicStep.gameObject.SetActive(false);

        creatTopicStepTip = rootTransform.FindChild("UI/RequestTopicer/creatTopicStep").gameObject;
        creatTopicStepTip.gameObject.SetActive(false);
    }



    /// <summary>
    /// 显示题主旁观答题界面
    /// </summary>
    /// <param name="num"></param>
    void ShowOnLookRequestTopicStep(int num)
    {
        if (num <= 0)
            return;
        InitOnLookRequestTopicStep(num);
        requestTopicOnLook.gameObject.SetActive(true);
    }

    /// <summary>
    /// 初始化旁观答题界面
    /// </summary>
    /// <param name="num"></param>
    void InitOnLookRequestTopicStep(int num)
    {
        if (num <= 0)
            return;
        if (requestTopicOnLook == null)
        {
            requestTopicOnLook = rootTransform.transform.FindChild("UI/CreateTopicer/requestTopicStep").gameObject;
            requestBigNumTempleOnLook = requestTopicOnLook.transform.FindChild("Content/BigNumTemple").gameObject;
            requestSmallNumTempleOnLook = requestTopicOnLook.transform.FindChild("Content/SmallNumTemple").gameObject;
            requestTopicNumParentOnLook = requestTopicOnLook.transform.FindChild("Content/Requester/RequestNums").transform;
            questionTopicNumParentOnLook = requestTopicOnLook.transform.FindChild("Content/CorrectQuestion/QuestionNums").transform;
            errorTipsOnLook = new GameObject[errorTipCount];
            for (int i = 0; i < errorTipCount; i++)
            {
                errorTipsOnLook[i] = requestTopicOnLook.transform.FindChild("ErrorTips/tip" + (i + 1).ToString()).gameObject;
                errorTipsOnLook[i].gameObject.SetActive(false);
            }
        }

        if (requestTopicNumsOnLook != null)
        {
            for (int i = 0; i < requestTopicNumsOnLook.Length; i++)
            {
                if (requestTopicNumsOnLook[i] != null)
                {
                    GameObject.Destroy(requestTopicNumsOnLook[i]);
                }
            }
        }

        requestTopicNumsOnLook = new GameObject[num.ToString().Length];
        InitNumContent(requestTopicNumsOnLook, requestTopicNumParentOnLook, requestBigNumTempleOnLook, requestSmallNumTempleOnLook);
        int index=num.ToString().Length-1;
        int kk = topWidths.Count;
        requestTopicOnLook.transform.FindChild("Content/Requester/leftBg").GetComponent<UISprite>().width=topWidths[index];
        requestTopicOnLook.transform.FindChild("Content/Requester/rightBg").GetComponent<UISprite>().width = topWidths[index];
        if (questionTopicNumsOnLook != null)
        {
            for (int i = 0; i < questionTopicNumsOnLook.Length; i++)
            {
                if (questionTopicNumsOnLook[i] != null)
                {
                    GameObject.Destroy(questionTopicNumsOnLook[i]);
                }
            }
        }
        questionTopicNumsOnLook = new GameObject[num.ToString().Length];
        InitNumContent(questionTopicNumsOnLook, questionTopicNumParentOnLook, requestBigNumTempleOnLook, requestSmallNumTempleOnLook);
        InitNumLable(questionTopicNumsOnLook, num.ToString());
        requestTopicOnLook.transform.FindChild("Content/CorrectQuestion/leftBg").GetComponent<UISprite>().width = bottomWidths[index];
        requestTopicOnLook.transform.FindChild("Content/CorrectQuestion/rightBg").GetComponent<UISprite>().width = bottomWidths[index];
        requestTopicOnLook.gameObject.SetActive(true);
    }

    /// <summary>
    /// 初始化答题界面
    /// </summary>
    /// <param name="num"></param>
    void InitRequestTopicStep(int num)
    {
        if (num <= 0)
            return;
        if (requestTopic == null)
        {
            requestTopic = rootTransform.transform.FindChild("UI/RequestTopicer/requestTopicStep").gameObject;
            requestBigNumTemple = requestTopic.transform.FindChild("Content/BigNumTemple").gameObject;
            requestSmallNumTemple = requestTopic.transform.FindChild("Content/SmallNumTemple").gameObject;
            requestTopicNumParent = requestTopic.transform.FindChild("Content/Nums").transform;
            errorTips = new GameObject[errorTipCount];
            for (int i = 0; i < errorTipCount; i++)
            {
                errorTips[i] = requestTopic.transform.FindChild("ErrorTips/tip" + (i + 1).ToString()).gameObject;
                errorTips[i].gameObject.SetActive(false);
            }
        }
        if (requestTopicNums != null)
        {
            for (int i = 0; i < requestTopicNums.Length; i++)
            {
                if (requestTopicNums[i] != null)
                {
                    GameObject.Destroy(requestTopicNums[i]);
                }
            }
        }

        requestTopicNums = new GameObject[num.ToString().Length];
        InitNumContent(requestTopicNums, requestTopicNumParent, requestBigNumTemple, requestSmallNumTemple);
        requestTopic.gameObject.SetActive(true);
    }

    /// <summary>
    /// 显示答题界面
    /// </summary>
    /// <param name="num"></param>
    void ShowRequestTopicStep(int num)
    {
        if (num <= 0)
            return;
        InitRequestTopicStep(num);
        requestTopic.gameObject.SetActive(true);
    }



    /// <summary>
    /// 输入数字
    /// </summary>
    /// <param name="numItems"></param>
    /// <param name="_value"></param>
    /// <returns></returns>
    string InitNumLable(GameObject[] numItems, string _value)
    {
        bool isEmpty = string.IsNullOrEmpty(_value);
        if (isEmpty)
        {
            for (int i = 0; i < numItems.Length; i++)
            {
                numItems[i].transform.FindChild("value").GetComponent<UILabel>().text = "";
            }
            _value = "";
        }
        else
        {
            if (_value.Length > numItems.Length)
                _value = _value.Substring(0, numItems.Length);
            for (int i = 0; i < numItems.Length; i++)
            {
                if (i < _value.Length)
                {
                    numItems[i].transform.FindChild("value").GetComponent<UILabel>().text = _value[i].ToString();
                }
                else
                {
                    numItems[i].transform.FindChild("value").GetComponent<UILabel>().text = "";
                }
            }
        }
        return _value;
    }

    /// <summary>
    /// 调整填写数字的方格个数
    /// </summary>
    /// <param name="numItems"></param>
    /// <param name="parent"></param>
    /// <param name="_bigNumTemple"></param>
    /// <param name="_smallNumTemple"></param>
    void InitNumContent(GameObject[] numItems, Transform parent, GameObject _bigNumTemple, GameObject _smallNumTemple)
    {
        if (numItems == null || parent == null || _bigNumTemple == null || _smallNumTemple == null)
        {
            Debug.LogError("Init numItem error!");
            return;
        }
        bool isSmall = numItems.Length > 6 ? true : false;
        Vector2 stepPos = isSmall ? smallNumPos : bigNumPos;
        Vector3 startPos = new Vector3(-(numItems.Length - 1) * (stepPos.x + stepPos.y) / 2, 0, 0);
        for (int i = 0; i < numItems.Length; i++)
        {
            GameObject tempNumItem = GameObject.Instantiate(isSmall ? _smallNumTemple : _bigNumTemple) as GameObject;
            tempNumItem.transform.parent = parent;
            tempNumItem.transform.localRotation = Quaternion.identity;
            tempNumItem.transform.localScale = Vector3.one;
            tempNumItem.transform.localPosition = new Vector3(startPos.x + (stepPos.x + stepPos.y) * i, startPos.y, startPos.z);
            numItems[i] = tempNumItem;
            numItems[i].gameObject.SetActive(true);
        }
    }

    void OnGUI()
    {
        if (GUI.Button(new Rect(20, 20, 100, 40), "Test"))
        {
            int num=Random.RandomRange(length,length*10);
            InitOnLookRequestTopicStep(num);
        }
    }


}


