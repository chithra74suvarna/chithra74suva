texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        AlphaOp[0] = SelectArg1;
        
        // Disable texture stage 1
	TexCoordIndex[1] = 0;
	Texture[1] = <tex0>;
        ColorOp[1] = BLENDCURRENTALPHA;
//        ColorOp[1] = SelectArg1;
	ColorArg2[1] = Current;
	ColorArg1[1] = Texture;
	AlphaArg1[1] = Texture;
        AlphaOp[1] = SelectArg1;
//        AlphaOp[1] = Disable;
    }
}
