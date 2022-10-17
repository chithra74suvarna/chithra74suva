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
        ColorOp[0] = SelectArg2;
 


	ZWriteEnable = false;
	ZEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = srccolor;
	SrcBlend = INVSrcColor;
	
//	AddressU[0] = WRAP;
//	AddressV[0] = WRAP;
	
//	cullmode=none;
    }
}
