Shader "Unlit/TwoTextures"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_SecondaryTex("Texture", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0
    }
    SubShader
    {
		Tags {
			"Queue" = "Transparent"
		}
        Pass
        {
			Blend SrcAlpha OneMinusSrcAlpha
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

            sampler2D _MainTex;
			sampler2D _SecondaryTex;
			float _Tween;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
           
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col1 = tex2D(_MainTex, i.uv);  
				fixed4 col2 = tex2D(_SecondaryTex, i.uv);
				fixed4 col = lerp(col1, col2, _Tween);
				return col;
            }
            ENDCG
        }
    }
}
