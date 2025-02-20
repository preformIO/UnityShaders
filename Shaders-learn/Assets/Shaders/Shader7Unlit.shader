﻿Shader "dahVEED/Shader7Unlit"
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
//// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members position)
//#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 position: TEXCOORD1;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float inCircle = 1 - step(0.25, length( i.position.xy ));
                fixed3 color = fixed3(1,1,0) * inCircle;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
