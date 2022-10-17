// -------------------------------------------------------------
// 전역변수
// -------------------------------------------------------------

float2 CenterTex  = { 0.5f, 0.5f };
float  SpeedRatio = 1.0f;
int Forward = 1;
 
// -------------------------------------------------------------
// 텍스쳐
// -------------------------------------------------------------
// 베이스 텍스쳐
texture tex0;
texture tex1;
sampler BaseSamp = sampler_state
{
	Texture = <tex0>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	
	AddressU = clamp;
	AddressV = clamp;
};
sampler BaseSamp2 = sampler_state
{
	Texture = <tex1>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	
	AddressU = clamp;
	AddressV = clamp;
};


float4 PS(in float2 Tex : TEXCOORD0 ) : COLOR
{
	float2 tTex;
	float alpha = tex2D( BaseSamp2, Tex).a;
	float4 color1 = tex2D( BaseSamp, Tex);
	float4 finalcolor;
//	if (alpha > 0.0f)
	{
		if (Forward == 1)
			tTex = CenterTex - Tex;
		else
			tTex = -CenterTex + Tex;
		tTex = tTex * SpeedRatio * 2.0f;
		float4 color2 = tex2D( BaseSamp, Tex + tTex*1.0f/96.0f);
		float4 color3 = tex2D( BaseSamp, Tex + tTex*2.0f/96.0f);
		float4 color4 = tex2D( BaseSamp, Tex + tTex*3.0f/96.0f);
		float4 color5 = tex2D( BaseSamp, Tex + tTex*4.0f/96.0f);
		float4 color6 = tex2D( BaseSamp, Tex + tTex*5.0f/96.0f);
		
		finalcolor =( color1+color2+color3+color4+color5+color6)/6.0f;
		finalcolor.a =  alpha * SpeedRatio * 2.0f;	
	}
//	else
	{
//		finalcolor = float4(alpha, alpha, alpha, alpha);
	}
	return finalcolor;
}


technique tec0
{
   pass p0
   {
        VertexShader = null;
        PixelShader  = compile ps_2_0 PS();
   }
}