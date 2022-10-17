texture tex0;

technique tec0
{
    pass p0
    {
//        MaterialAmbient = {0.5, 0.5, 0.5, 1.0}; 
//        MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
//        MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
//        MaterialPower = 40.0f;

//	DiffuseMaterialSource = material;	
	// Turn lighting on and use light 0
       
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        
        // Disable texture stage 1
	
//	MipFilter[0] = Linear;
//	MinFilter[0] = Linear;
//	MagFilter[0] = Linear;
	
//	CULLMODE = CCW;
    }
}
