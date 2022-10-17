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
        ColorOp[0] = SelectArg1;
        AlphaOp[0] = modulate;
        
        // Disable texture stage 1

	zwriteenable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
//	SrcBlend = SRCALPHA;

	CullMode = none;
	
	fogenable = false;
	
    }
}
