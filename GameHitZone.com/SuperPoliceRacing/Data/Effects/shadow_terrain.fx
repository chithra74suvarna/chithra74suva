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



	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Subtract;
	DestBlend = one;
	SrcBlend = srccolor;
	
//	DepthBias = 0.01;
//	SlopeScaleDepthBias = 0.01;
	
//	CULLMODE = none;
	
	AddressU[0] = CLAMP;
	AddressV[0] = CLAMP;
    }
}
