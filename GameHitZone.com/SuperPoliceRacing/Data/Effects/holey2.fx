// Sample effect file

texture tex0;

technique tec0

{
	pass p0
	{
	
	
 	
	lighting = false;
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		AlphaOp[0] = selectarg1;
		MipFilter[0] = none;
	
		AlphaTestEnable = true;
		AlphaRef = 0x00000040;
		AlphaFunc = GreaterEqual;
		cullmode = none;
//		zwriteenable = true;
		zfunc = less;
		
  		
	}
}
