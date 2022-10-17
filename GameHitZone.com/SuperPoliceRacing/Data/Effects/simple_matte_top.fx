texture tex0;

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        
        // Disable texture stage 1
	ZEnable = false;
    }
}
