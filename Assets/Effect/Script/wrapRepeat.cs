using UnityEngine;
using System.Collections;

public class wrapRepeat : MonoBehaviour {
	
	// Use this for initialization
	void Start () 
	{
		GetComponent<Renderer>().material.mainTexture.wrapMode = TextureWrapMode.Repeat;
	}
}
