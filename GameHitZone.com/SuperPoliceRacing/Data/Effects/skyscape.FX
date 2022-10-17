texture tex0;

technique tec0
{
    pass p0
    {
 //   	ColorWriteEnable = Red | Green | Blue;
	// Turn lighting on and use light 0
        Lighting = false;
        
	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        ColorOp[0] = modulate;
	ColorArg1[0] = Diffuse;
        ColorArg2[0] = Texture;
	
        // Disable texture stage 1
//	AddressU[0] = WRAP;
	AddressV[0] = CLAMP;
//	cullmode = NONE;
	
//	MinFilter[0] = POINT;
//	MagFilter[0] = POINT;
//	MipFilter[0] = NONE;
	
	fogenable = false;
	
   }
}
