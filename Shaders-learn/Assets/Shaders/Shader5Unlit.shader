﻿Shader "dahVEED/Shader5Unlit"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f // vertex to fragment
            {
                //SYMANTECS in ALL CAPS     // system value position
                float4 vertex: SV_POSITION; // coordinate of vertex in clip space (x, y, z) = [-1, 1]
                float4 position: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 color = saturate(i.position * 2);
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
