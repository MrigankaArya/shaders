Shader "Unlit/TestShader1"
{
    Properties
    {
		_Color("Main Color", Color) = (1,1,1,1) //Defines a color property called Main Color and assigns it a default pink color with alpha 1
    }
    SubShader
    {
		Pass {											//Object is rendered in Pass
			
			CGPROGRAM // Indicates that the code following this is written in cgFX

			#pragma vertex vert	// Tells the program that the code contains a vertex program in the function
			#pragma fragment frag	//Tells the program that the code contains a fragment program in the function
			#include "UnityCG.cginc"	//Contains commonly used declarations so the code can be kept smaller. used for appdata_base here
		
			struct appdata {	//Info from each vertex on the mesh
				float4 vertex: POSITION;	//Local vertex position
				float2 uv: TEXCOORD0;		//uv coordinates
				//float4 tangent: TANGENT;		
				//float2 lightmap_uv: TEXCOORD1;	//lightmap uv coordinates
				//float3 normal: NORMAL;		//normal
				float3 normal : NORMAL;
			};
		
			struct v2f {	//vertex to fragment
				float4 pos: SV_POSITION;	//Screen Clip space position and depth
				float2 uv : TEXCOORD0;		
				fixed3 color : COLOR0;
			};

			
			
			v2f vert(appdata v)	//color is computed here
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = v.normal * 0.5 + 0.5;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target{	//color is only outputted here
				return fixed4(i.color, 1);
			}

			ENDCG	//ends cgFX code
						
		}
    }
}
