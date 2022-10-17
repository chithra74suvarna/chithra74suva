// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;

//	Texturefactor = 0;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = SelectArg1;
   //     ColorArg1[0] = Texture;
        //ColorArg2[0] = Tfactor;
//        ColorArg1[1] = current | complement;
        AlphaOp[0] = Modulate;


//	ColorOp[1] = SelectArg1;
//	AlphaOp[1] = disable;

	ZWriteEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;
//	CullMode = none;
    }
}
