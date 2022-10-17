
texture tex0;  // texture for scene rendering
texture tex1; // texture for environment map

float4x4 g_mWorldViewProjection : WORLDVIEWPROJECTION; // World * View * Projection matrix
float4 Ambient = {0.3f, 0.3f, 0.3f, 1.0f};      // Ambient color of the material
shared float4 g_vAmbient;      // Ambient color

sampler g_samScene =
sampler_state
{
    Texture = <tex0>;
};
sampler g_samScene2 =
sampler_state
{
    Texture = <tex1>;
};


void VertScene(
	float4 vPos : POSITION,
	float3 vNormal : NORMAL,
	float2 vTex0 : TEXCOORD0,
	float2 vTex1 : TEXCOORD1,
	out float4 oPos : POSITION,
	out float4 oDiffuse : COLOR0,
	out float2 oTex0 : TEXCOORD0,
	out float2 oTex1 : TEXCOORD1)
{
	oPos = mul( vPos, g_mWorldViewProjection );
	oDiffuse = g_vAmbient * Ambient;
	
	oTex0 = vTex0;
	oTex1 = vTex1;
}


//-----------------------------------------------------------------------------
// Name: PixScene
// Type: Pixel shader
// Desc: This shader outputs the pixel's color by modulating the texture's
//		 color with diffuse material color
//-----------------------------------------------------------------------------
void PixScene(
	float4 MatDiffuse : COLOR0,
	float2 Tex0 : TEXCOORD0,
	float2 Tex1 : TEXCOORD1,
	out float4 ret_color : COLOR0)
{
	ret_color = tex2D(g_samScene, Tex0) * tex2D(g_samScene2, Tex1) + MatDiffuse;
}

technique tec0
{
	pass P0
	{
		VertexShader = compile vs_1_1 VertScene();
		PixelShader  = compile ps_1_1 PixScene();

	}
}
