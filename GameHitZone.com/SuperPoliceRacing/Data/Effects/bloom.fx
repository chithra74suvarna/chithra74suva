//-----------------------------------------------------------------------------
// File: PP_ColorBrightPass.fx
//
// Desc: Effect file for image post-processing sample.  This effect contains
//       a single technique with a pixel shader that performs a bright pass
//       on the input texture.
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------




texture tex0;

sampler2D g_samSrcColor =
sampler_state
{
    Texture = <tex0>;
//    AddressU = Clamp;
//    AddressV = Clamp;
//    MinFilter = Point;
//    MagFilter = Linear;
//   MipFilter = Linear;
};

float Luminance = 0.020f;
static const float fMiddleGray = 0.12f;
static const float fWhiteCutoff = 0.8f;
float3 LuminanceConv = { 0.2125f, 0.7154f, 0.0721f };

//-----------------------------------------------------------------------------
// Pixel Shader: BrightPassFilter
// Desc: Perform a high-pass filter on the source texture
//-----------------------------------------------------------------------------

static const int g_cKernelSize = 13;

//static const float g_cXSize = 256.0f;
//static const float g_cYSize = 192.0f;
static const float g_cXSize = 512.0f;
static const float g_cYSize = 384.0f;


float PixelKernel[g_cKernelSize] =
{
    { -6 / g_cXSize },
    { -5 / g_cXSize },
    { -4 / g_cXSize },
    { -3 / g_cXSize },
    { -2 / g_cXSize },
    { -1 / g_cXSize },
    {  0 },
    {  1 / g_cXSize },
    {  2 / g_cXSize },
    {  3 / g_cXSize },
    {  4 / g_cXSize },
    {  5 / g_cXSize },
    {  6 / g_cXSize },
};

float PixelKernel2[g_cKernelSize] =
{
    { -6 / g_cYSize },
    { -5 / g_cYSize },
    { -4 / g_cYSize },
    { -3 / g_cYSize },
    { -2 / g_cYSize },
    { -1 / g_cYSize },
    {  0 },
    {  1 / g_cYSize },
    {  2 / g_cYSize },
    {  3 / g_cYSize },
    {  4 / g_cYSize },
    {  5 / g_cYSize },
    {  6 / g_cYSize },
};

//float2 TexelKernel[g_cKernelSize]
//<
//    string ConvertPixelsToTexels = "PixelKernel";
//>;




static const float BlurWeights[g_cKernelSize] = 
{
    0.002216,
    0.008764,
    0.026995,
    0.064759,
    0.120985,
    0.176033,
    0.199471,
    0.176033,
    0.120985,
    0.064759,
    0.026995,
    0.008764,
    0.002216,
};




float BloomScale = 1.0f;


float4 Contrast( in float2 Tex : TEXCOORD0 ) : COLOR0
{

    float3 ColorOut = tex2D( g_samSrcColor, Tex );

    ColorOut *= fMiddleGray / ( Luminance + 0.001f );
    ColorOut *= ( 1.0f + ( ColorOut / ( fWhiteCutoff * fWhiteCutoff ) ) );
    ColorOut -= 5.0f;

    ColorOut = max( ColorOut, 0.0f );

    ColorOut /= ( 10.0f + ColorOut );

    return float4( ColorOut, 1.0f );
   
}


float4 HorzBloom( in float2 Tex : TEXCOORD0 ) : COLOR0
{

    float4 Color = 0;

    for (int i = 0; i < g_cKernelSize; i++)
    {    
        Color += tex2D( g_samSrcColor, Tex + float2(PixelKernel[i], 0) ) * BlurWeights[i];
    }

    return Color * BloomScale;
  
}

float4 VertBloom( in float2 Tex : TEXCOORD0 ) : COLOR0
{

    float4 Color = 0;

    for (int i = 0; i < g_cKernelSize; i++)
    {    
        Color += tex2D( g_samSrcColor, Tex + float2(0, PixelKernel2[i]) ) * BlurWeights[i];
    }

    return Color * BloomScale;
}

float4 Grayscale( float2 Tex : TEXCOORD0 ) : COLOR0
{
    return dot( (float3)tex2D( g_samSrcColor, Tex ), LuminanceConv );
}

float4 Sepia( float2 Tex : TEXCOORD0 ) : COLOR0
{
    float4 vWeightsBW=float4(0.3,0.59,0.11,0);
    float4 vWeightsSepia=float4(1.0,0.8,0.6,1); 
    float4 cColor=tex2D( g_samSrcColor, Tex ); 
    float  brightness=dot(cColor,vWeightsBW);  
    return brightness*vWeightsSepia * 0.7 + cColor * 0.3;
}



//-----------------------------------------------------------------------------
// Technique: PostProcess
// Desc: Performs post-processing effect that converts a colored image to
//       black and white.
//-----------------------------------------------------------------------------
technique tec0
{

    pass p0
    {
        VertexShader = null;
        PixelShader = compile ps_2_0 Contrast();
        ZEnable = false;
    }


/*    pass p0
    {
        VertexShader = null;
        PixelShader = compile ps_2_0 Sepia();
        ZEnable = false;
    }
    
    pass p1
    {
        VertexShader = null;
        PixelShader = compile ps_2_0 Grayscale();
        ZEnable = false;
    }
 */   
//    pass p1
//    {
//       VertexShader = null;
//        PixelShader = compile ps_2_0 HorzBloom();
//        ZEnable = false;
//    }

//    pass p2
//    {
//        VertexShader = null;
//        PixelShader = compile ps_2_0 VertBloom();
//        ZEnable = false;
//    }
//    pass p3
//    {
//        VertexShader = null;
//        PixelShader = compile ps_2_0 VertBloom();
//        ZEnable = false;
//    }

}
