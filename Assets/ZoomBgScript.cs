using UnityEngine;
using System.Collections;

public class ZoomBgScript : MonoBehaviour {

	// Use this for initialization
    float scrollSpeed   = 0.5f;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
    float scaleX   = Mathf.Cos ( Time.time ) * 0.5f + 1;
	float scaleY   = Mathf.Sin ( Time.time ) * 0.5f + 1;
     gameObject.GetComponent<Renderer>().material.mainTextureScale =new Vector2 (scaleX,scaleY);

	float offset   = Time.time * scrollSpeed;
    gameObject.GetComponent<Renderer>().material.mainTextureOffset =new Vector2(offset, 0);
	}
}
