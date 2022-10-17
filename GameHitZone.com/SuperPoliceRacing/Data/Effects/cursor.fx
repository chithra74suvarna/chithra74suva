texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
        Lighting = false;

	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        ColorOp[0] = SelectArg1;
	
	TexCoordIndex[1] = 1;
        // Set up texture stage 0
	Texture[1] = <tex1>;
        ColorOp[1] = SelectArg2;
        AlphaOp[1] = SelectArg1;
	
	CullMode = NONE;
        
        // Disable texture stage 1

	ZEnable = false;
	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;

//	AddressV[0] = CLAMP;
//	AddressU[0] = CLAMP;

	MinFilter[0] = Point;
	MagFilter[0] = Point;
	MipFilter[0] = Point;
    }
}
