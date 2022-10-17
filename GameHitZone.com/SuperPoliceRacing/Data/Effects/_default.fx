texture tex0;

technique tec0
{
    pass p0
    {
        // Set up reasonable material defaults
        MaterialAmbient = {1.0, 1.0, 1.0, 1.0}; 
        MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
        MaterialSpecular = {1.0, 1.0, 1.0, 1.0}; 
        MaterialPower = 10.0f;

	DiffuseMaterialSource = material;	
	Ambient = {0.5, 0.5, 0.5, 1.0}; 
        
	// Turn lighting on and use light 0
	SpecularEnable = true;
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
//	CullMode = CCW;
        
        // Disable texture stage 1
    }
}
