texture tex0;

technique tec0
{
    pass p0
    {
        Lighting = false;
	
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
	ColorOp[0] = SelectArg1;
        AlphaOp[0] = Modulate;
//	CullMode = NONE;
        
        // Disable texture stage 1

	ZEnable = false;
	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
	SrcBlend = SRCALPHA;

	AddressV[0] = CLAMP;
	AddressU[0] = CLAMP;

//	MinFilter[0] = LINEAR;
//	MagFilter[0] = LINEAR;
	MipFilter[0] = NONE;
    }
}
