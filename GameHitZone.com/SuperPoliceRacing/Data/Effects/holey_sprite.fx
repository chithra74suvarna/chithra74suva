// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        AlphaOp[0] = SelectArg1;
	MipFilter[0] = none;
//	MinFilter[0] = LINEAR;	
//	MagFilter[0] = LINEAR;	


	ColorOp[1] = SelectArg1;
	AlphaOp[1] = disable;

	AlphaTestEnable = true;
//	AlphaRef = 0x00000000;
	AlphaFunc = Greater;
	
	CULLMODE = NONE;
    }
}
