// Sample effect file

texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;

	TexCoordIndex[0] = 1;
	Texture[0] = <tex1>;        
        ColorOp[0] = SelectArg1;
        AlphaOp[0] = SelectArg1;

	TexCoordIndex[1] = 1;
	Texture[1] = <tex1>;        

//        ColorArg1[1] = Texture;
//        ColorArg2[1] = Current;
//        AlphaArg1[1] = Texture;
//        AlphaArg2[1] = Current;

//	ColorOp[1] = SelectArg2;
//	AlphaOp[1] = SelectArg1;

//	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = One;
//	SrcBlend = SRCALPHA;
    }
}
