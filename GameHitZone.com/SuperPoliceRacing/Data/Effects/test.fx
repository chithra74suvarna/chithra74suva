texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
//        Lighting = t;
//	SpecularEnable = true;
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        ColorOp[0] = SelectArg1;
        AlphaOp[0] = Disable;

	CullMode = none;
	FillMode = wireframe;
	LastPixel = true;
    }
}
