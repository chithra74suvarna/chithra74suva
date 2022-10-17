texture tex0;

texture tex1;

technique t0
{
pass p0 
{	
	fogenable=false;
		
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		ColorOp[0] = Modulate;
//		TexCoordIndex[1] = 1; 
//		Texture[1] = <tex1>;   		
//		ColorOp[1] = Modulate;   
//		Texture[1] = <tex2>;   		
//		ColorOp[1] = Modulate;   

		AlphaBlendEnable = true;
		BlendOp = SUBTRACT;
		DestBlend = ONE;
		SrcBlend = ONE;

//		ZEnable = false;   
//		ZWriteEnable = false;
}
   pass p1
  {	
		TextureFactor = 0xFFFFFFFF;
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		ColorOp[0] = SelectArg1;
		ColorArg1[0] = TFACTOR;
		AlphaArg1[0] = TEXTURE;
		AlphaOp[0] = SelectArg1;		
		AlphaOp[1] = disable;		
		Texture[1] = <tex1>;   
		TexCoordIndex[1] = 1; 
		ColorOp[1] = BLENDCURRENTALPHA;
//		ZEnable = false;
	
		AlphaBlendEnable = true;
		BlendOp = Add;
		DestBlend = SRCCOLOR;
		SrcBlend = ZERO;

//		ZWriteEnable = false;
 }
 
//    pass p2
   // {	
//		TextureFactor = 0xFF000000;
//		TexCoordIndex[0] = 0;
//		Texture[0] = <tex0>;        
//		ColorOp[0] = SelectArg2;
//		ColorArg2[0] = TFACTOR;
//		AlphaOp[0] = SelectArg1;		
//		AlphaOp[1] = SelectArg2;
//		AlphaArg2[1] = Current;		
//		Texture[1] = <tex3>;   
//		TexCoordIndex[1] = 1; 
//		ColorOp[1] = BLENDCURRENTALPHA;
//		ZEnable = false;
		
//		AlphaBlendEnable = true;
//		BlendOp = Add;
//		DestBlend = ONE;
//		SrcBlend = ONE;
		
//		ZFunc = EQUAL;		
//		ZEnable = false;   
//		ZWriteEnable = false;
//}
}