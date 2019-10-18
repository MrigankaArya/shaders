Shader "Unlit/AlphaBlending"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
		Tags{
			"Queue" = "Transparent" //Makes texture render after the geometry along with all the other transparent stuff
		}
        Pass
        {
			Blend SrcAlpha OneMinusSrcAlpha //This is used to blend the alphas of the image so that the transparent parts remain transparent

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
          
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float4 normal: NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
				float4 color:COLOR0;
            };

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
				o.color = v.normal * 0.5 + 0.5;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv*2)*i.color;
                return col;
            }
            ENDCG
        }
    }
}
