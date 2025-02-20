﻿Shader "dahVEED/Shader29Unlit"
{
    Properties
    {
        _ColorA("Color A", Color) = (1, 0, 0, 1)
        _ColorB("Color B", Color) = (1, 1, 0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM

            #pragma vertex vert_img
            #pragma fragment frag
          
            #include "UnityCG.cginc"

            fixed4 _ColorA;
            fixed4 _ColorB;

            float random (float2 pt) {
                const float a = 12.9898;
                const float b = 78.233;
                const float c = 43758.543123;
                return frac(sin(dot(pt, float2(a, b))) * c );
            }

            // 2D Noise based on Morgan McGuire @morgan3d
            // https://www.shadertoy.com/view/4dS3Wd
            float noise (float2 st) {
                float2 i = floor(st);
                float2 f = frac(st);

                // Four corners in 2D of a tile
                float a = random(i);
                float b = random(i + float2(1.0, 0.0));
                float c = random(i + float2(0.0, 1.0));
                float d = random(i + float2(1.0, 1.0));

                // Smooth Interpolation

                // Cubic Hermine Curve.  Same as SmoothStep()
                float2 u = f*f*(3.0-2.0*f);
                // u = smoothstep(0.,1.,f);

                // Mix 4 coorners percentages
                return lerp(a, b, u.x) +
                        (c - a)* u.y * (1.0 - u.x) +
                        (d - b) * u.x * u.y;
            }

            fixed4 frag (v2f_img i) : SV_Target
            {
                // Scale the coordinate system to see some noise in action
                float2 pos = float2(i.uv.x * 1.4 + 0.01, i.uv.y - _Time.y * 0.69);
                float n = noise(pos * 12.0);
                pos = float2(i.uv.x * 0.5 - 0.033, i.uv.y * 2.0 - _Time.y * 0.12);
                n += noise(pos * 8.0);
                pos = float2(i.uv.x * 0.94 - 0.02, i.uv.y * 3.0 - _Time.y * 0.61);
                n += noise(pos * 4.0);
                n /= 3.0;

                fixed3 color = lerp(_ColorA, _ColorB, n);
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
