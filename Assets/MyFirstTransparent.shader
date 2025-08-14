Shader "Unlit/MyFirstTransparent"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
                "Queue"="Transparent"}

        Pass
        {
            // Src = Source
                // Frag shader
            // Dst = Destination
                // Render Target
            // (Src * A)   [op]   (Dst * B)
            
            // Blend One One / Additive
            // (Src * 1) + (Dst * 1) 
            
            // Blend DstColor Zero // Multiplicative
            // (Src * DstColor) + (Dst * 0)
            
            //Blend DstColor SrcColor // 2X Multiplicative
            // (Src * DstColor) + (Dst * SrcColor)
            
            // Blend SrcAlpha OneMinusSrcAlpha // Traditional
            // (Src * SrcAlpha) + (Dst * OneMinusSrcAlpha)
            
            // Blend OneMinusDstColor One // Soft Additive
            // (Src * 1-Dst) + (Dst * 1)
            
            
            ZWrite Off
            // BlendOp RevSub // Dst - Src
            //BlendOp Sub // Src - Dst
            //Blend One One
            //Blend Zero One
            // Blend One One // Additive
             Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
            
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
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                
                return float4(0 ,0 ,1, 0.5);
            }
            ENDCG
        }
    }
}
