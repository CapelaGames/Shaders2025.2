Shader "Unlit/HealthBar"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Health ("Health", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            //float _Health;

            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float, _Health)
            UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v,o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                float health = UNITY_ACCESS_INSTANCED_PROP(Props, _Health);
                float shake = (sin(_Time.y * 50) * 0.02)* (health < 0.2);
                o.vertex.y += shake;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                float health = UNITY_ACCESS_INSTANCED_PROP(Props, _Health);
               // float healthbarMask = health > floor( i.uv.x * 8) /8;
                float healthbarMask = health >  i.uv.x ;

                // Clamp01 = saturate
                float3 sinColor = lerp(sin(_Time.y * 10) * 0.5 + 0.5, 1, health > 0.3);
                float3 barColor = float3(0,0.6,0) * saturate(0.2 + i.uv.x);
                barColor *= sinColor;
                float3 bgColor = (0.1).xxx * (1 - i.uv.x);
                
                float3 outColor = lerp(bgColor, barColor, healthbarMask);
                
                return float4(outColor,1);
                
                //return float4 (outColor,1);
            }
            ENDCG
        }
    }
}
