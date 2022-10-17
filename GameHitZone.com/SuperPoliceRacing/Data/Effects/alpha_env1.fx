// Sample effect file

// Here is a texture parameter
texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
//    ADDRESSU[1] = WRAP;
//    ADDRESSV[1] = WRAP;
	// Turn lighting on and use light 0
//	LOCALVIEWER = false;
        
        // Set up texture stage 0
        Texture[0] = <tex0>; // Use the texture parameter defined above
        AlphaOp[0] = SelectArg1;
//        MinFilter[0] = Linear;
//        MagFilter[0] = Linear;
//        MipFilter[0] = Linear;

        // Set up texture stage 0
        Texture[1] = <tex1>; // Use the texture parameter defined above       
        ColorOp[1] = MODULATEALPHA_ADDCOLOR;
        ColorArg2[1] = Texture;
        ColorArg1[1] = Current;
        AlphaOp[1] = Disable;//SelectArg1;
        AlphaArg1[1] = Current;
        AlphaArg2[1] = Diffuse;
//        MinFilter[1] = Linear;
//        MagFilter[1] = Linear;
//        MipFilter[1] = Linear;

//        Texturetransform[1] = <mattr>;
        Texcoordindex[1] = CAMERASPACEREFLECTIONVECTOR;
//        Texturetransformflags[1] = count3;

       
        // Disable texture stage 1
        ColorOp[2] = Disable;
        AlphaOp[2] = Disable;
    }
}
