// Sample effect file

texture tex0;

technique tec0
{
    pass p0
    {
        Lighting = false;
 //       MaterialAmbient = {0.05, 0.05, 0.05, 1.0}; 
    //    MaterialDiffuse = {1, 1, 1, 1.0}; 
//        MaterialSpecular = {0.3, 0.3, 0.3, 1.0}; 
   //     MaterialPower = 20.0f;

//	DiffuseMaterialSource = material;	
    
	
 	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        AlphaOp[0] = modulate;
        
        // Disable texture stage 1

	ZWriteEnable = false;
	ZEnable = false;

	AlphaBlendEnable = true;
	BlendOp = Add;
//	DestBlend = INVSRCALPHA;
//	SrcBlend = SRCALPHA;

//	CullMode = NONE;
	fogenable = false;
	ColorWriteEnable = Red | Green | Blue;
	
    }
}
