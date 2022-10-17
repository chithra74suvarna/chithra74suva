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
        AlphaOp[0] = SelectArg2;


	ZWriteEnable = false;
	fogenable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
//	SrcBlend = SRCALPHA;

//	CullMode = NONE;
    }
}
