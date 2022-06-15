Shader "dahVEED/Shader3Unlit"
{
    Properties
    {
        _ColorA("Color A", Color) = (1, 0, 0, 1)
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

            fixed4 frag (v2f_img i) : SV_Target
            {
                return _ColorA;
            }
            ENDCG
        }
    }
}
