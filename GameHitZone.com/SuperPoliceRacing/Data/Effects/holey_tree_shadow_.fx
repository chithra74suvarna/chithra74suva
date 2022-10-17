// Sample effect file

texture tex0;
texture tex1;

technique tec0

{
	pass p0
	{
		lighting = false;
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		AlphaOp[0] = selectarg1;
		MipFilter[0] = linear;
		MipFilter[1] = linear;
		TexCoordIndex[1] = 1;
		Texture[1] = <tex1>;
		ColorOp[1] = modulate;
        AlphaOp[1] = disable;
	
		AlphaTestEnable = true;
		AlphaRef = 0x00000010;
		AlphaFunc = GreaterEqual;
		cullmode = ccw;
//		zwriteenable = true;
//		zfunc = less;
		
  		
	}
}