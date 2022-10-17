texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        ColorOp[0] = SelectArg1;
        
        // Disable texture stage 1
//	cullmode = ccw;
    }
}
