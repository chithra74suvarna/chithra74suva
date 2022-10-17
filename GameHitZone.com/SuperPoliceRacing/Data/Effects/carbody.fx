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
shared float4x4 g_mView;               // View matrix for object
shared float4x4 g_mWorldViewProjection : WORLDVIEWPROJECTION; // World * View * Projection matrix
shared float4x4 g_mViewProjection; // World * View * Projection matrix
//float4x4 g_mProj;                                       // Projection matrix for object
shared float4x4 g_mViewInv;                             // Inverse of view matrix
shared float4 g_vLightColor = {1.0f, 1.0f, 1.0f, 1.0f}; // Light value
shared float  g_fTime;                                  // Time value
shared float4 g_vLight;                                 // Light position in view space
shared float4 g_vAmbient;      // Ambient color
shared float3 g_vCameraPos;                                 // Light position in view space
float  g_fSizeMul = 1.0f;                               // A size multiplier
float  g_fAnimSpeed;                                    // Animation speed
shared float4x4 g_mWorld : WORLD;

// Object material attributes
float4 Diffuse = {1.0f, 1.0f, 1.0f, 1.0f};      // Diffuse color of the material
float4 Ambient = {0.4f, 0.4f, 0.4f, 1.0f};      // Ambient color of the material
float4 Specular = {0.9f, 0.9f, 0.9f, 1.0f};  // Specular color of the material
float  Reflectivity = 0.5f; // Reflectivity of the material
float  Power = 30.0f;


//-----------------------------------------------------------------------------
// Texture samplers
//-----------------------------------------------------------------------------
sampler g_samScene =
sampler_state
{
    Texture = <tex0>;
  //  MinFilter = Linear;
  //  MagFilter = Linear;
  //  MipFilter = None;
};

sampler g_samEnv =
sampler_state
{
    Texture = <tex1>;
  //  MipFilter = Linear;
  //  MinFilter = Linear;
  //  MagFilter = Linear;
};
sampler g_samEnv2 =
sampler_state
{
    Texture = <tex2>;
  //  MipFilter = Linear;
  //  MinFilter = Linear;
  //  MagFilter = Linear;
};

//-----------------------------------------------------------------------------
// Name: VertScene
// Type: Vertex shader
// Desc: This shader computes standard transform and lighting
//-----------------------------------------------------------------------------
void VertScene( float4 vPos : POSITION,
                float3 vNormal : NORMAL,
                float2 vTex0 : TEXCOORD0,
                float4 vDiffuse: COLOR0,
                out float4 oPos : POSITION,
                out float4 oDiffuse : COLOR0,
                out float2 oTex0 : TEXCOORD0,
                out float3 oViewPos : TEXCOORD1,
                out float3 oViewNormal : TEXCOORD2,
                out float3 oEnvTex : TEXCOORD3 )
{
    // Transform the position from object space to homogeneous projection space
    oPos = mul( vPos, g_mViewProjection );
//    oPos = mul( vPos, g_mWorldView );
//    oPos = mul( oPos, g_mProj );

    // Compute the view-space position
    oViewPos = mul( vPos, g_mView );

      // Compute view-space normal
    oViewNormal = normalize( mul( vNormal, (float3x3)g_mView ) );
   float3 _oViewNormal = vNormal;//mul( vNormal, (float3x3)g_mWorld ) ;

    // Compute lighting
    oDiffuse = dot( _oViewNormal, -g_vLight);// + g_vAmbient * Ambient ;//normalize( g_vLight - oViewPos ) ) * Diffuse;

    oDiffuse.a = vDiffuse.a;
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
	float3  _vLight = mul( g_vLight, (float3x3)g_mView );
   float3 vHalf = normalize( normalize( -ViewPos ) - _vLight );


    // Compute normal dot half for specular light
    float4 fSpecular =  Specular * pow( saturate( dot( vHalf, normalize( ViewNormal ) ) ), Power );

//	float3 R = normalize(reflect(g_vLight, g_vNormal));
//     float4 fSpecular =  Specular * pow(max(0, dot(R, -ViewPos)), Power);

	float tex_alpha = tex2D( g_samScene, Tex0 )[3];

    // Lookup mesh texture and modulate it with diffuse
    return float4( (float3)( g_vLightColor * ( tex2D( g_samScene, Tex0 ) * (MatDiffuse * Diffuse  + g_vAmbient * Ambient) + fSpecular * tex_alpha)
                             + texCUBE( g_samEnv, EnvTex ) * Reflectivity * tex_alpha * (MatDiffuse + Ambient / 2.0f)
                           )/* * MatDiffuse.a + (1 - MatDiffuse.a) * tex2D( g_samEnv2, Tex0 )*/, 1.0f );
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
//	CullMode = NONE;
    }
}





