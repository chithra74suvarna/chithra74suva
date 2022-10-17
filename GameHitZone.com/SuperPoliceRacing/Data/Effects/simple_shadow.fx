//-----------------------------------------------------------------------------
// Global variables
//-----------------------------------------------------------------------------
texture tex0;  // texture for scene rendering
texture tex1;  // texture for road mask
float4x4 g_mWorld : WORLD;               // View matrix for object

float4x4 g_mWorldView : WORLDVIEW;               // View matrix for object
float4x4 g_mWorldViewProjection : WORLDVIEWPROJECTION; // World * View * Projection matrix
shared float4x4 g_mViewInv;                             // Inverse of view matrix
shared float4 g_vLightColor = {1.0f, 1.0f, 1.0f, 1.0f}; // Light value
shared float3 g_vLight;                                 // Light position in view space
shared float3 g_vCameraPos;                                 // Light position in view space
shared float4 g_vFogColor = {1.0f, 0.0f, 1.0f, 1.0f};                                 // Light position in view space
shared float g_fFogMinDistance = 50;                                 // Light position in view space
shared float g_fFogMaxDistance = 600;                                 // Light position in view space
shared float4 g_vAmbient;      // Ambient color
float  g_fSizeMul = 1.0f;                               // A size multiplier
float  g_fAnimSpeed;                                    // Animation speed

// Object material attributes
float4 Diffuse = {1.0f, 1.0f, 1.0f, 1.0f};      // Diffuse color of the material
float4 Ambient = {0.3f, 0.3f, 0.3f, 1.0f};      // Ambient color of the material
float4 Specular = {0.3f, 0.3f, 0.3f, 1.0f};  // Specular color of the material
float  Reflectivity = 0.9f; // Reflectivity of the material
float  Power = 20.0f;


sampler g_samScene =
sampler_state
{
    Texture = <tex0>;
    AddressU = WRAP;
    AddressV = Wrap;
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
};


sampler g_samMask =
sampler_state
{
    Texture = <tex1>;
    AddressU = Clamp;
    AddressV = Clamp;
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
};

struct VS_INPUT
{
	float4 Pos	: POSITION;
	float3 Normal	: NORMAL;
	float2 Tex0	: TEXCOORD0;
	float2 Tex1	: TEXCOORD1;
};

struct VS_OUTPUT
{
	float4 	Pos 		: POSITION;
	float4 	Diffuse 	: COLOR0;
	float2 	Tex 		: TEXCOORD0;
	float2  MaskTex		: TEXCOORD1;
	float3 	RealPos 	: TEXCOORD2;
	float3 	RealNormal	: TEXCOORD3;
	float	Fog 		: FOG;
};

void VSScene(in VS_INPUT i, out VS_OUTPUT o)
{
	o.Pos		= mul(i.Pos, g_mWorldViewProjection);
	o.RealNormal	= mul(i.Normal, g_mWorld);
	o.RealPos	= mul(i.Pos, g_mWorld);
	o.Tex		= i.Tex0;
	o.MaskTex	= i.Tex1;

	float dist	= min(g_fFogMaxDistance, distance(g_vCameraPos, o.RealPos));
	o.Fog		= (g_fFogMaxDistance - dist) / (g_fFogMaxDistance - g_fFogMinDistance);

	o.Diffuse	= g_vAmbient * Ambient;
	
}

float4 PSScene(in VS_OUTPUT i) : COLOR0
{
	float NDotL = dot(normalize(i.RealNormal), -g_vLight);
	float3 vHalf = normalize(normalize(g_vCameraPos - i.RealPos) - g_vLight);
	float4 fSpecular = saturate((NDotL + 0.12f) * 30) * lit(NDotL + 0.12f, dot(vHalf, normalize(i.RealNormal)), Power).z * Specular * g_vLightColor;

	float4 result;
	float4 tcolor = tex2D(g_samScene, i.Tex);

	result = (i.Diffuse + max(0, NDotL) * Diffuse * g_vLightColor) * tcolor + fSpecular;
	return result;
}

technique tec0
{
	pass P0
	{
		VertexShader = compile vs_2_0 VSScene();
		PixelShader = compile ps_2_0 PSScene();
		lighting = false;
		alphablendenable = false;
		fogenable = false;
	}
}
