// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
    ADDRESSU[0] = Clamp;
    ADDRESSV[0] = Clamp;
    
	// Turn lighting on and use light 0
        Lighting = false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = SelectArg1;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] = Disable;
        AlphaArg1[0] = Texture;
        AlphaArg2[0] = Diffuse;
	

	ColorOp[1] = SelectArg1;
	AlphaOp[1] = disable;

	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = One;
	SrcBlend = One;
    }
}
