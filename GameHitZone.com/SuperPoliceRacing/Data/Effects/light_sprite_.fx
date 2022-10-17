// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
        // Set up reasonable material defaults
//        MaterialAmbient = {0.8, 0.8, 0.8, 1.0}; 
 //       MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
 //       MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
  //      MaterialPower = 40.0f;

//	DiffuseMaterialSource = material;	
//	Ambient = {1.0, 1.0, 1.0, 1.0}; 
        
	// Turn lighting on and use light 0
        Lighting = false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
 	ColorOp[1] = disable;
	AlphaOp[1] = disable;
	AlphaOp[0] = Modulate;
 	ColorOp[0] = Modulate;
//	ColorArg1[0] = Texture;

	ZWriteEnable = false;
	ZEnable= true;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
	SrcBlend = SRCCOLOR;

	CullMode = NONE;
	fogenable = false;
    }
}
