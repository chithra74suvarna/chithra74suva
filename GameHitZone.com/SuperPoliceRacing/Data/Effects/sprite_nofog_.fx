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
        ColorOp[0] = Modulate;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
//        AlphaOp[0] = Modulate;
//        AlphaArg1[0] = Texture;
//        AlphaArg2[0] = Diffuse;



	ZWriteEnable = false;
	ZEnable= false;

	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
	SrcBlend = SRCCOLOR;

//!	AddressU[0] = CLAMP;
//!	AddressV[0] = CLAMP;

	CullMode = NONE;
	fogenable = false;
    }
}
