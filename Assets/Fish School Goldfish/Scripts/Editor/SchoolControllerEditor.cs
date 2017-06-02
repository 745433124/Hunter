/****************************************	
	Copyright 2015 Unluck Software	
 	www.chemicalbliss.com																															
*****************************************/
using UnityEngine;
using System.Collections;
using UnityEditor;
using System;
[CustomEditor(typeof(SchoolController))]
class SchoolControllerEditor : Editor
{
	SerializedProperty myProperty;
	SerializedProperty bubbles ;
    SchoolController targetObj = null;
    public void OnEnable()
	{
        targetObj = target as SchoolController;
        if (targetObj ._bubbles == null)
		{
            targetObj._bubbles = (SchoolBubbles)Transform.FindObjectOfType(typeof(SchoolBubbles));
		}
		myProperty = serializedObject.FindProperty("_childPrefab");
		bubbles = serializedObject.FindProperty("_bubbles");
	}

	public override void OnInspectorGUI()
	{
		Color warningColor  =new Color32(255, 174, 0, 255);
		Color warningColor2  = Color.yellow;
		Color dColor  =new Color32(175, 175, 175, 255);
		Color aColor = Color.white;
		GUIStyle warningStyle = new GUIStyle(GUI.skin.label);
		warningStyle.normal.textColor = warningColor;
		warningStyle.fontStyle = FontStyle.Bold;
		var warningStyle2 = new GUIStyle(GUI.skin.label);
		warningStyle2.normal.textColor = warningColor2;
		warningStyle2.fontStyle = FontStyle.Bold;
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		if(UnityEditor.EditorApplication.isPlaying)
		{
			GUI.enabled = false;
		}
		targetObj._updateDivisor = (int)EditorGUILayout.Slider("Frame Skipping", targetObj._updateDivisor, 1, 10);
		GUI.enabled = true;
		if(targetObj._updateDivisor > 4)
		{
			EditorGUILayout.LabelField("Will cause choppy movement", warningStyle);
		}
		else if(targetObj._updateDivisor > 2)
		{
			EditorGUILayout.LabelField("Can cause choppy movement	", warningStyle2);
		}
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		serializedObject.Update();
		EditorGUILayout.PropertyField(myProperty, new GUIContent("Fish Prefabs"), true);
		serializedObject.ApplyModifiedProperties();
		EditorGUILayout.LabelField("Prefabs must have SchoolChild component", EditorStyles.miniLabel);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Grouping", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Move fish into a parent transform", EditorStyles.miniLabel);
		targetObj._groupChildToSchool = EditorGUILayout.Toggle("Group to School", targetObj._groupChildToSchool);
		if(targetObj._groupChildToSchool)
		{
			GUI.enabled = false;
		}
		targetObj._groupChildToNewTransform = EditorGUILayout.Toggle("Group to New GameObject", targetObj._groupChildToNewTransform);
		targetObj._groupName = EditorGUILayout.TextField("Group Name", targetObj._groupName);
		GUI.enabled = true;
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Bubbles", EditorStyles.boldLabel);
		EditorGUILayout.PropertyField(bubbles, new GUIContent("Bubbles Object"), true);
		if(targetObj._bubbles)
		{
			targetObj._bubbles._emitEverySecond = EditorGUILayout.FloatField("Emit Every Second", targetObj._bubbles._emitEverySecond);
			targetObj._bubbles._speedEmitMultiplier = EditorGUILayout.FloatField("Fish Speed Emit Multiplier", targetObj._bubbles._speedEmitMultiplier);
			targetObj._bubbles._minBubbles = EditorGUILayout.IntField("Minimum Bubbles Emitted", targetObj._bubbles._minBubbles);
			targetObj._bubbles._maxBubbles = EditorGUILayout.IntField("Maximum Bubbles Emitted", targetObj._bubbles._maxBubbles);
			if(GUI.changed)
			{
				EditorUtility.SetDirty(targetObj._bubbles);
			}
		}
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Area Size", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Size of area the school roams within", EditorStyles.miniLabel);
		targetObj._positionSphere = EditorGUILayout.FloatField("Roaming Area Width", targetObj._positionSphere);
		targetObj._positionSphereDepth = EditorGUILayout.FloatField("Roaming Area Depth", targetObj._positionSphereDepth);
		targetObj._positionSphereHeight = EditorGUILayout.FloatField("Roaming Area Height", targetObj._positionSphereHeight);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Size of the school", EditorStyles.boldLabel);     
		EditorGUILayout.LabelField("Size of area the Fish swim towards", EditorStyles.miniLabel);
		targetObj._childAmount = (int)EditorGUILayout.Slider("Fish Amount", targetObj._childAmount, 0f, 500f);
		targetObj._spawnSphere = EditorGUILayout.FloatField("School Width", targetObj._spawnSphere);
		targetObj._spawnSphereDepth = EditorGUILayout.FloatField("School Depth", targetObj._spawnSphereDepth);
		targetObj._spawnSphereHeight = EditorGUILayout.FloatField("School Height", targetObj._spawnSphereHeight);
		EditorGUILayout.EndVertical();
        //add by YY 2016-3-24
        GUI.color = dColor;
        EditorGUILayout.BeginVertical("Box");
        GUI.color = Color.white;
        EditorGUILayout.LabelField("Item of the schoolController", EditorStyles.boldLabel);
        targetObj._colSchoolCtrl = EditorGUILayout.ColorField("School Height", targetObj._colSchoolCtrl);
        targetObj._liveTotalTime = (int)EditorGUILayout.FloatField("FishSwimTime", targetObj._liveTotalTime);
        EditorGUILayout.EndVertical();

        //end by YY 2016-3-24

		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Speed and Movement ", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Change Fish speed, rotation and movement behaviors", EditorStyles.miniLabel);
		targetObj._childSpeedMultipler = EditorGUILayout.FloatField("Random Speed Multiplier", targetObj._childSpeedMultipler);
		targetObj._speedCurveMultiplier = EditorGUILayout.CurveField("Speed Curve Multiplier", targetObj._speedCurveMultiplier);
		if(targetObj._childSpeedMultipler < 0.01) targetObj._childSpeedMultipler = 0.01f;
		targetObj._minSpeed = EditorGUILayout.FloatField("Min Speed", targetObj._minSpeed);
		targetObj._maxSpeed = EditorGUILayout.FloatField("Max Speed", targetObj._maxSpeed);
		targetObj._acceleration = EditorGUILayout.Slider("Fish Acceleration", targetObj._acceleration, 0.001f, 0.07f);
		targetObj._brake = EditorGUILayout.Slider("Fish Brake Power", targetObj._brake, 0.001f, 0.025f);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Rotation Damping", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Bigger number damping will make Fish turn faster", EditorStyles.miniLabel);
		targetObj._minDamping = EditorGUILayout.FloatField("Min Damping Turns", targetObj._minDamping);
		targetObj._maxDamping = EditorGUILayout.FloatField("Max Damping Turns", targetObj._maxDamping);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Randomize Fish Size ", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Change scale of Fish when they are added to the stage", EditorStyles.miniLabel);
		targetObj._minScale = EditorGUILayout.FloatField("Min Scale", targetObj._minScale);
		targetObj._maxScale = EditorGUILayout.FloatField("Max Scale", targetObj._maxScale);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Fish Random Animation Speeds", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Animation speeds are also increased by movement speed", EditorStyles.miniLabel);
		targetObj._minAnimationSpeed = EditorGUILayout.FloatField("Min Animation Speed", targetObj._minAnimationSpeed);
		targetObj._maxAnimationSpeed = EditorGUILayout.FloatField("Max Animation Speed", targetObj._maxAnimationSpeed);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Fish Waypoint Distance", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Waypoints inside small sphere", EditorStyles.miniLabel);
		targetObj._waypointDistance = EditorGUILayout.FloatField("Distance To Waypoint", targetObj._waypointDistance);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Fish Triggers School Waypoint", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Fish waypoint triggers a new School waypoint", EditorStyles.miniLabel);
		targetObj._childTriggerPos = EditorGUILayout.Toggle("Fish Trigger Waypoint", targetObj._childTriggerPos);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Automaticly New Waypoint", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Automaticly trigger new school waypoint", EditorStyles.miniLabel);
		targetObj._autoRandomPosition = EditorGUILayout.Toggle("Auto School Waypoint", targetObj._autoRandomPosition);
		if(targetObj._autoRandomPosition)
		{
			targetObj._randomPositionTimerMin = EditorGUILayout.FloatField("Min Delay", targetObj._randomPositionTimerMin);
			targetObj._randomPositionTimerMax = EditorGUILayout.FloatField("Max Delay", targetObj._randomPositionTimerMax);
			if(targetObj._randomPositionTimerMin < 1)
			{
				targetObj._randomPositionTimerMin = 1;
			}
			if(targetObj._randomPositionTimerMax < 1)
			{
				targetObj._randomPositionTimerMax = 1;
			}
		}
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Fish Force School Waypoint", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Force all Fish to change waypoints when school changes waypoint", EditorStyles.miniLabel);
		targetObj._forceChildWaypoints = EditorGUILayout.Toggle("Force Fish Waypoints", targetObj._forceChildWaypoints);
		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Force New Waypoint Delay", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("How many seconds until the Fish in school will change waypoint", EditorStyles.miniLabel);
		targetObj._forcedRandomDelay = EditorGUILayout.FloatField("Waypoint Delay", targetObj._forcedRandomDelay);
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		EditorGUILayout.LabelField("Obstacle Avoidance", EditorStyles.boldLabel);
		EditorGUILayout.LabelField("Steer and push away from obstacles (uses more CPU)", EditorStyles.miniLabel);
		targetObj._avoidance = EditorGUILayout.Toggle("Avoidance (enable/disable)", targetObj._avoidance);
		if(targetObj._avoidance)
		{
			targetObj._avoidAngle = EditorGUILayout.Slider("Avoid Angle", targetObj._avoidAngle, 0.05f, 0.95f);
			targetObj._avoidDistance = EditorGUILayout.FloatField("Avoid Distance", targetObj._avoidDistance);
			if(targetObj._avoidDistance <= 0.1) targetObj._avoidDistance = 0.1f;
			targetObj._avoidSpeed = EditorGUILayout.FloatField("Avoid Speed", targetObj._avoidSpeed);
			targetObj._stopDistance = EditorGUILayout.FloatField("Stop Distance", targetObj._stopDistance);
			targetObj._stopSpeedMultiplier = EditorGUILayout.FloatField("Stop Speed Multiplier", targetObj._stopSpeedMultiplier);
			if(targetObj._stopDistance <= 0.1) targetObj._stopDistance = 0.1f;
		}
		EditorGUILayout.EndVertical();
		GUI.color = dColor;
		EditorGUILayout.BeginVertical("Box");
		GUI.color = Color.white;
		targetObj._push = EditorGUILayout.Toggle("Push (enable/disable)", targetObj._push);
		if(targetObj._push)
		{
			targetObj._pushDistance = EditorGUILayout.FloatField("Push Distance", targetObj._pushDistance);
			if(targetObj._pushDistance <= 0.1) targetObj._pushDistance = 0.1f;
			targetObj._pushForce = EditorGUILayout.FloatField("Push Force", targetObj._pushForce);
			if(targetObj._pushForce <= 0.01) targetObj._pushForce = 0.01f;
		}
		EditorGUILayout.EndVertical();
		if(GUI.changed) EditorUtility.SetDirty(targetObj);
	}
}