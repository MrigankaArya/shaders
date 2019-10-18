Shader "Unlit/GradientShader"
{
	SubShader
	{
		Pass {											//Object is rendered in Pass

			CGPROGRAM // Indicates that the code following this is written in cgFX

			#pragma vertex vert	// Tells the program that the code contains a vertex program in the function
			#pragma fragment frag	//Tells the program that the code contains a fragment program in the function
			#include "UnityCG.cginc"	//Contains commonly used declarations so the code can be kept smaller. used for appdata_base here

			struct appdata {	//Info from each vertex on the mesh
				float4 vertex: POSITION;
				float2 uv: TEXCOORD0;
			};

			struct v2f {	//vertex to fragment
				float4 pos: SV_POSITION;
				float2 uv : TEXCOORD0;
			};



			v2f vert(appdata v)	//color is computed here
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target{	//color is only outputted here
				return fixed4(i.uv.x, i.uv.y, 1, 1);
			}

			ENDCG	//ends cgFX code

		}
	}
}