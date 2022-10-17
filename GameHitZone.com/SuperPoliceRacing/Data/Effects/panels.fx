// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
//	SpecularEnable = false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = SelectArg1;
        AlphaOp[0] = SelectArg1;

	MipFilter[0] = none;
	MinFilter[0] = none;
	MagFilter[0] = none;

	AlphaTestEnable = true;
	AlphaFunc = Greater;
	ZEnable = false;
	ZWriteEnable = false;
CullMode = none;
    }
}
