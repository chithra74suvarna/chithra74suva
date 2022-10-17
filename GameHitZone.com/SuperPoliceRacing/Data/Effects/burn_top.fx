// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = SelectArg1;
        AlphaOp[0] = SelectArg1;
 


	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = One;
//	SrcBlend = SrcAlpha;

	ZEnable = false;
    }
}
