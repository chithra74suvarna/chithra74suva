//-----------------------------------------------------------------------------
// File: Flyer.fx
//
// Desc: The effect file for the EffectMesh sample.  The technique implements:
//
//       Texture mapping
//       Diffuse lighting
//       Specular lighting
//       Environment mapping
// 
// Copyright (c) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Global variables
//-----------------------------------------------------------------------------
texture tex0;  // texture for scene rendering
texture tex1; // texture for environment map
texture tex2; // texture for environment map

shared float4x4 g_mWorldView : WORLDVIEW;               // View matrix for object
shared float4x4 g_mWorldViewProjection : WORLDVIEWPROJECTION; // World * View * Projection matrix
//float4x4 g_mProj;                                       // Projection matrix for object
shared float4x4 g_mViewInv;                             // Inverse of view matrix
shared float4 g_vLightColor = {1.0f, 1.0f, 1.0f, 1.0f}; // Light value
shared float  g_fTime;                                  // Time value
shared float3 g_vLight;                                 // Light position in view space
float  g_fSizeMul = 1.0f;                               // A size multiplier
float  g_fAnimSpeed;                                    // Animation speed

// Object material attributes
float4 Diffuse = {0.9f, 0.9f, 0.9f, 1.0f};      // Diffuse color of the material
float4 Specular = {0.2f, 0.2f, 0.2f, 1.0f};  // Specular color of the material
float  Reflectivity = 0.1f; // Reflectivity of the material
float  Power = 5.0f;


//-----------------------------------------------------------------------------
// Texture samplers
//-----------------------------------------------------------------------------
sampler g_samScene =
sampler_state
{
    Texture = <tex0>;
//    MinFilter = Linear;
//    MagFilter = Linear;
//    MipFilter = None;
};

sampler g_samEnv =
sampler_state
{
    Texture = <tex1>;
//    MipFilter = Linear;
//    MinFilter = Linear;
//    MagFilter = Linear;
};


//-----------------------------------------------------------------------------
// Name: VertScene
// Type: Vertex shader
// Desc: This shader computes standard transform and lighting
//-----------------------------------------------------------------------------
void VertScene( float4 vPos : POSITION,
                float3 vNormal : NORMAL,
                float2 vTex0 : TEXCOORD0,
                out float4 oPos : POSITION,
                out float4 oDiffuse : COLOR0,
                out float2 oTex0 : TEXCOORD0,
                out float3 oViewPos : TEXCOORD1,
                out float3 oViewNormal : TEXCOORD2,
                out float3 oEnvTex : TEXCOORD3 )
{
    // Transform the position from object space to homogeneous projection space
oPos = mul( vPos, g_mWorldViewProjection );
//    oPos = mul( vPos, g_mWorldView );
//    oPos = mul( oPos, g_mProj );

    // Compute the view-space position
    oViewPos = mul( vPos, g_mWorldView );

    // Compute view-space normal
    oViewNormal = normalize( mul( vNormal, (float3x3)g_mWorldView ) );

    // Compute lighting
    oDiffuse = dot( oViewNormal, normalize( g_vLight - oViewPos ) ) * Diffuse;
//    oDiffuse = dot( oViewNormal, normalize( g_vLight) ) * Diffuse;

    // Just copy the texture coordinate through
    oTex0 = vTex0;

    // Compute the texture coord for the environment map.
    oEnvTex = 2 * dot( -oViewPos, oViewNormal ) * oViewNormal + oViewPos;
    oEnvTex = mul( oEnvTex, (float3x3)g_mViewInv );
}


//-----------------------------------------------------------------------------
// Name: PixScene
// Type: Pixel shader
// Desc: This shader outputs the pixel's color by modulating the texture's
//		 color with diffuse material color
//-----------------------------------------------------------------------------
float4 PixScene( float4 MatDiffuse : COLOR0,
                 float2 Tex0 : TEXCOORD0,
                 float3 ViewPos : TEXCOORD1,
                 float3 ViewNormal : TEXCOORD2,
                 float3 EnvTex : TEXCOORD3 ) : COLOR0
{
    // Compute half vector for specular lighting
    float3 vHalf = normalize( normalize( -ViewPos ) + normalize( g_vLight - ViewPos ) );
//    float3 vHalf = normalize( normalize( -ViewPos ) + normalize( g_vLight) );

    // Compute normal dot half for specular light
    float4 fSpecular = pow( saturate( dot( vHalf, normalize( ViewNormal ) ) ) * Specular, Power );

    // Lookup mesh texture and modulate it with diffuse
    return float4( (float3)( g_vLightColor * ( tex2D( g_samScene, Tex0 ) * MatDiffuse + fSpecular ) * ( 1 - Reflectivity )
                             + texCUBE( g_samEnv, EnvTex ) * Reflectivity
                           ), 1.0f );
}


void VertScene1x( float4 vPos : POSITION,
                  float3 vNormal : NORMAL,
                  float2 vTex0 : TEXCOORD0,
                  out float4 oPos : POSITION,
                  out float4 oDiffuse : COLOR0,
                  out float4 oSpecular : COLOR1,
                  out float2 oTex0 : TEXCOORD0,
                  out float3 oEnvTex : TEXCOORD1 )
{
    // Transform the position from object space to homogeneous projection space
    oPos = mul( vPos, g_mWorldViewProjection );

    // Compute the view-space position
    float4 ViewPos = mul( vPos, g_mWorldView );

    // Compute view-space normal
    float3 ViewNormal = normalize( mul( vNormal, (float3x3)g_mWorldView ) );

    // Compute diffuse lighting
    oDiffuse = dot( ViewNormal, normalize( g_vLight - ViewPos ) ) * Diffuse;

    // Compute specular lighting
    // Compute half vector
    float3 vHalf = normalize( normalize( -ViewPos ) + normalize( g_vLight - ViewPos ) );

    // Compute normal dot half for specular light
    oSpecular = pow( saturate( dot( vHalf, ViewNormal ) ) * Specular, Power );

    // Just copy the texture coordinate through
    oTex0 = vTex0;

    // Compute the texture coord for the environment map.
    oEnvTex = 2 * dot( -ViewPos, ViewNormal ) * ViewNormal + ViewPos;
    oEnvTex = mul( oEnvTex, (float3x3)g_mViewInv );
}


float4 PixScene1x( float4 MatDiffuse : COLOR0,
                   float4 MatSpecular : COLOR1,
                   float2 Text0 : TEXCOORD0,
                   float3 EnvTex : TEXCOORD1 ) : COLOR0
{
    // Lookup mesh texture and modulate it with diffuse
    return ( MatDiffuse * tex2D( g_samScene, Text0 ) + MatSpecular ) * ( 1 - Reflectivity ) + texCUBE( g_samEnv, EnvTex ) * Reflectivity;
}


//-----------------------------------------------------------------------------
// Name: RenderScene
// Type: Technique
// Desc: Renders scene to render target
//-----------------------------------------------------------------------------

technique tec0
{
    pass P0
    {
        VertexShader = compile vs_1_1 VertScene();
        PixelShader  = compile ps_2_0 PixScene();
//        ZEnable = true;
//        AlphaBlendEnable = false;
FogEnable = false;
    }
}



technique tec1
{
    pass p0
    {
       MaterialAmbient = {0.1, 0.1, 0.1, 1.0}; 

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
//        AlphaOp[0] = SelectArg1;

       // Set up texture stage 0
        Texture[1] = <tex2>; // Use the texture parameter defined above       
        ColorOp[1] = Add;
        AlphaOp[1] = SelectArg2;

      Texcoordindex[1] = CAMERASPACEREFLECTIONVECTOR;
      TextureTransformFlags[1] = COUNT2;
        
        // Disable texture stage 1
        ColorOp[2] = Disable;
        AlphaOp[2] = Disable;

	ZWriteEnable = true;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;
	
//	CullMode = CW;
    }
}

