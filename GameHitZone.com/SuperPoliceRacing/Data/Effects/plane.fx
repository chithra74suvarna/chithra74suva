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

	ZWriteEnable = false;
	ZEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;
    }
}
