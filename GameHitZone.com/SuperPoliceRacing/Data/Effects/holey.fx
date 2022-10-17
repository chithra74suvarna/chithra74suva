// Sample effect file

texture tex0;

technique tec0

{
	pass p0
	{
	
	
       // Set up reasonable material defaults
        MaterialAmbient = {1.0, 1.0, 1.0, 1.0}; 
        MaterialDiffuse = {0.0, 0.0, 0.0, 0.0}; 
        MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
        MaterialPower = 40.0f;

	DiffuseMaterialSource = material;	
	
	lighting = true;
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		AlphaOp[0] = selectarg1;
		MipFilter[0] = linear;
	
		AlphaTestEnable = true;
		AlphaRef = 0x00000040;
		AlphaFunc = GreaterEqual;
		cullmode = none;
//		zwriteenable = true;
		zfunc = less;
		
  		
	}
}
