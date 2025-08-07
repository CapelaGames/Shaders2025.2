Shader "OurShaders/MyFirstShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };
            
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.normal = mul(unity_ObjectToWorld, v.normal);
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                return float4((sin(i.uv.x) * 0.5 + 0.5).xxx ,1);

                //return float4((i.uv % 0.1).xxx,1);

            }
            ENDCG
        }
    }
}

// fixed 11 bits -2.0 to 2.0 used mostly for numbers between 0 and 1 (has precision of 1/256)
// fixed2, fixed3, fixed4

// half 16 bits
// half2, half3, half4

// float 32 bits
// float  4.5
// float2 4.6, 6.8
// float3 4.6, 6.8, 4.0
// float4 4.6, 6.8, 4.0, 0.1

// int 
// int2, int3, int4

// bool, 0 or 1

// sampler2d   2D texture
// samplerCUBE 3D texture


