shared float4x4 g_mWorldView : WORLDVIEW;  
shared float4x4 g_mWorldViewProjection : WORLDVIEWPROJECTION;
shared float4x4 g_mViewInv; 
shared float4 g_vLightColor;
shared float  g_fTime; 
shared float4 g_vLight; 
shared float3 g_vCameraPos; 
shared float4 g_vAmbient;

texture tex0; 
texture tex1; 
texture tex2; 

sampler g_smpNoMip =
sampler_state
{
    Texture = <tex0>;
//    MinFilter = Linear;
//    MagFilter = Linear;
//    MipFilter = None;
};

sampler g_smpTrilinear =
sampler_state
{
    Texture = <tex1>;
//    MipFilter = Linear;
//    MinFilter = Linear;
//    MagFilter = Linear;
};

//#include "sharedvars.fxh"




float4 Diffuse = {0.99f, 0.99f, 0.99f, 1.0f};
float4 Ambient = {0.7f, 0.7f, 0.7f, 1.0f}; 
float4 Specular = {0.99f, 0.99f, 0.99f, 1.0f};
float  Reflectivity = 0.8f;
float  Power = 1.0f;

void VertScene( 	float4 vPos : POSITION,
			float3 vNormal : NORMAL,
			float2 vTex0 : TEXCOORD0,
			out float4 oPos : POSITION,
			out float4 oDiffuse : COLOR0,
			out float2 oTex0 : TEXCOORD0,
			out float3 oRealPos : TEXCOORD1,
			out float3 oRealNormal : TEXCOORD2,
			out float3 oEnvTex : TEXCOORD3)
{
    oPos = mul( vPos, g_mWorldViewProjection );
    float3 ViewPos = mul( vPos, g_mWorldView );
    float3 ViewNormal = normalize( mul( vNormal, (float3x3)g_mWorldView ) );
    oDiffuse = g_vAmbient * Ambient;
    oRealNormal = vNormal;
    oRealPos  =  vPos;
    oTex0 = vTex0;
    oEnvTex = 2 * dot( -ViewPos, ViewNormal ) * ViewNormal + ViewPos;
    oEnvTex = mul( oEnvTex, (float3x3)g_mViewInv );
}

float4 PixScene( 	 float4 MatDiffuse : COLOR0,
			 float2 Tex0 : TEXCOORD0,
			 float3 RealPos : TEXCOORD1,
			 float3 RealNormal : TEXCOORD2,	 
			 float3 EnvTex : TEXCOORD3 ) : COLOR0
{
	float NDotL = dot(normalize(RealNormal), -g_vLight);
	MatDiffuse += max(0, NDotL) * Diffuse * g_vLightColor;

	float3 vHalf = normalize(normalize(g_vCameraPos - RealPos) - g_vLight);
	float4 fSpecular = NDotL * lit(NDotL, dot(normalize(RealNormal), vHalf), Power) * Specular * g_vLightColor;

 	float4 tcolor = tex2D(g_smpNoMip, Tex0);
	return float4((MatDiffuse.rgb + fSpecular.rgb * tcolor.a) * tcolor.rgb + tex2D(g_smpTrilinear, EnvTex).rgb * Reflectivity * tcolor.a, (1.0f - tcolor.a));

}


technique tec0
{
    pass P0
    {
        VertexShader = compile vs_2_0 VertScene();
        PixelShader  = compile ps_2_0 PixScene();
//        ZEnable = true;
        AlphaBlendEnable = true;
	FogEnable = false;
// 	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;
// 	CullMode = CCW;
  }
}
