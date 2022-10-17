texture tex0;

technique tec0
{
    pass p0
    {
    
//        MaterialAmbient = {0.7, 0.7, 0.7, 1.0}; 
//        MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
//        MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
//        MaterialPower = 20.0f;
//	DiffuseMaterialSource = material;	


	// Turn lighting on and use light 0
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        
        // Disable texture stage 1
	
//	MipFilter[0] = Linear;
//	MinFilter[0] = Linear;
//	MagFilter[0] = Linear;
	
//	AddressU[0] = WRAP;
//	AddressV[0] = WRAP;
	
//	CULLMODE = CCW;
    }
}
