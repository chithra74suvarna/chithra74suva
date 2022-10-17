// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;
	fogenable=false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = SelectArg1;


	ColorOp[1] = SelectArg1;
	AlphaOp[1] = disable;

	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = One;
	SrcBlend = One;
	CULLMODE = none;
    }
}
