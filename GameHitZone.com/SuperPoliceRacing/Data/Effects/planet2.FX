// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
        Lighting = false;
	
 	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        ColorOp[0] = addsmooth;
	ColorArg1[0] = current;
	ColorArg2[0] = Texture;
        AlphaOp[0] = modulate;
         
        // Disable texture stage 1

	zwriteenable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;

	CullMode = none;
	
	fogenable = false;
    }
}
