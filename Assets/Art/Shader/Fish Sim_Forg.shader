// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:Mobile/Diffuse,iptp:0,cusa:False,bamd:0,lico:0,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:False,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:False,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:1,fgcg:1,fgcb:1,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:32967,y:32345,varname:node_4013,prsc:2|diff-3839-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32021,y:32450,ptovrint:False,ptlb:Main Color,ptin:_MainColor,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5073529,c2:0.5073529,c3:0.5073529,c4:1;n:type:ShaderForge.SFN_Tex2d,id:8680,x:32021,y:32267,varname:node_8680,prsc:2,ntxv:0,isnm:False|TEX-6758-TEX;n:type:ShaderForge.SFN_Depth,id:1862,x:30963,y:31660,cmnt:获取摄像机平面到对象的距离值,varname:node_1862,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5348,x:32407,y:32351,cmnt:最终颜色混合,varname:node_5348,prsc:2|A-6133-OUT,B-8680-RGB,C-1304-RGB;n:type:ShaderForge.SFN_OneMinus,id:6133,x:32194,y:32146,cmnt:取反值,varname:node_6133,prsc:2|IN-4092-OUT;n:type:ShaderForge.SFN_Multiply,id:4092,x:31979,y:32077,varname:node_4092,prsc:2|A-1931-OUT,B-7690-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:6758,x:31766,y:32348,ptovrint:False,ptlb:Base (RGB),ptin:_MainTex,varname:node_6758,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:6230,x:31580,y:32146,ptovrint:False,ptlb:Fog Color,ptin:_FogColor,varname:_Color_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.2132353,c2:0.3235294,c3:0.8529412,c4:1;n:type:ShaderForge.SFN_OneMinus,id:7690,x:31766,y:32146,cmnt:取反值,varname:node_7690,prsc:2|IN-6230-RGB;n:type:ShaderForge.SFN_ValueProperty,id:5745,x:30963,y:32013,ptovrint:False,ptlb:Far,ptin:_Far,varname:node_5745,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:5;n:type:ShaderForge.SFN_Clamp,id:4849,x:31258,y:31755,cmnt:限制输出的取值范围最小不小于Min最大不大于Max,varname:node_4849,prsc:2|IN-1862-OUT,MIN-8479-OUT,MAX-5745-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8479,x:30963,y:31890,ptovrint:False,ptlb:Near,ptin:_Near,varname:node_8479,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Subtract,id:6787,x:31457,y:31995,varname:node_6787,prsc:2|A-5745-OUT,B-8479-OUT;n:type:ShaderForge.SFN_Subtract,id:9863,x:31457,y:31838,varname:node_9863,prsc:2|A-4849-OUT,B-8479-OUT;n:type:ShaderForge.SFN_Divide,id:1931,x:31733,y:31921,cmnt:数据归一化处理,varname:node_1931,prsc:2|A-9863-OUT,B-6787-OUT;n:type:ShaderForge.SFN_Tex2d,id:1384,x:32021,y:32680,ptovrint:False,ptlb:Cookie,ptin:_Cookie,varname:node_1384,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8582-OUT;n:type:ShaderForge.SFN_Add,id:3839,x:32617,y:32515,varname:node_3839,prsc:2|A-5348-OUT,B-9725-OUT;n:type:ShaderForge.SFN_NormalVector,id:2258,x:31787,y:32924,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:2379,x:31993,y:32985,varname:node_2379,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-2258-OUT;n:type:ShaderForge.SFN_Multiply,id:9725,x:32294,y:32796,varname:node_9725,prsc:2|A-1384-RGB,B-4299-OUT;n:type:ShaderForge.SFN_Clamp01,id:4299,x:32199,y:32985,varname:node_4299,prsc:2|IN-2379-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9689,x:31472,y:32870,ptovrint:False,ptlb:Cookie Size,ptin:_CookieSize,varname:node_9689,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_FragmentPosition,id:1524,x:31237,y:32557,varname:node_1524,prsc:2;n:type:ShaderForge.SFN_ComponentMask,id:5854,x:31472,y:32596,varname:node_5854,prsc:2,cc1:0,cc2:2,cc3:-1,cc4:-1|IN-1524-XYZ;n:type:ShaderForge.SFN_Multiply,id:8582,x:31678,y:32724,varname:node_8582,prsc:2|A-5854-OUT,B-9689-OUT;proporder:1304-6758-6230-8479-5745-1384-9689;pass:END;sub:END;*/

Shader "Shader Forge/Fish Sim_Forg" {
    Properties {
        _MainColor ("Main Color", Color) = (0.5073529,0.5073529,0.5073529,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _FogColor ("Fog Color", Color) = (0.2132353,0.3235294,0.8529412,1)
        _Near ("Near", Float ) = 1
        _Far ("Far", Float ) = 5
        _Cookie ("Cookie", 2D) = "white" {}
        _CookieSize ("Cookie Size", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _MainColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _FogColor;
            uniform float _Far;
            uniform float _Near;
            uniform sampler2D _Cookie; uniform float4 _Cookie_ST;
            uniform float _CookieSize;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 node_8680 = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float2 node_8582 = (i.posWorld.rgb.rb*_CookieSize);
                float4 _Cookie_var = tex2D(_Cookie,TRANSFORM_TEX(node_8582, _Cookie));
                float3 diffuseColor = (((1.0 - (((clamp(partZ,_Near,_Far)-_Near)/(_Far-_Near))*(1.0 - _FogColor.rgb)))*node_8680.rgb*_MainColor.rgb)+(_Cookie_var.rgb*saturate(i.normalDir.g)));
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Mobile/Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
