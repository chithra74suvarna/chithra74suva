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
    MipFilter = None;
};

sampler g_smpTrilinear =
sampler_state
{
    Texture = <tex1>;
 //   MipFilter = Linear;
 //   MinFilter = Linear;
 //   MagFilter = Linear;
};
