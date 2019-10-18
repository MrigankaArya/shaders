﻿Shader "Unlit/Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {} //Adding texture as a property, white when no texture is assigned
		_Color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {	
		Tags {
			"Queue" = "Transparent"
		}
        Pass
        {
			//Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

			sampler2D _MainTex; //Need to define or the shader won't compile
			float4 _Color;

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv)*_Color; //Get color value from maintex at the provided uv
                return col;
            }
            ENDCG
        }
    }
}
