// Sample effect file

// Here is a texture parameter
texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
        // Set up reasonable material defaults
        MaterialAmbient = {0.8, 0.8, 0.8, 1.0}; 
        MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
        MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
        MaterialPower = 40.0f;

	DiffuseMaterialSource = material;	
	Ambient = {0.7, 0.7, 0.7, 1.0}; 
        
	// Turn lighting on and use light 0
        
        // Set up texture stage 0
        Texture[0] = <tex0>; // Use the texture parameter defined above
//        MinFilter[0] = Linear;
//        MagFilter[0] = Linear;
//        MipFilter[0] = Linear;

        // Set up texture stage 0
        Texture[1] = <tex1>; // Use the texture parameter defined above       
        ColorOp[1] = Add;
        ColorArg1[1] = Texture;
        ColorArg2[1] = Current;
        AlphaOp[1] = Disable;
        AlphaArg1[1] = Texture;
        AlphaArg2[1] = Diffuse;
//        MinFilter[1] = Linear;
//        MagFilter[1] = Linear;
//        MipFilter[1] = Linear;

//        Texturetransform[1] = <mattr>;
        Texcoordindex[1] = CAMERASPACEREFLECTIONVECTOR;
        Texturetransformflags[1] = count3;

       
        // Disable texture stage 1
        ColorOp[2] = Disable;
        AlphaOp[2] = Disable;
    }
}
