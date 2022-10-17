texture tex0;

texture tex1;

texture tex2;

technique t0
{
pass p0 
{	
//	SpecularEnable = false;
		
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		ColorOp[0] = SelectArg1;
		AlphaOp[0] = SelectArg1;
		TexCoordIndex[1] = 1; 
		Texture[1] = <tex2>;   		
		ColorOp[1] = BLENDCURRENTALPHA;
		AlphaOp[0] = SelectArg1;
		AlphaArg1[1] = CURRENT;

		TexCoordIndex[2] = 1; 
		Texture[2] = <tex1>;   		
		ColorOp[2] = BLENDCURRENTALPHA;
		AlphaOp[2] = SelectArg1;
		ColorArg1[2] = Texture;
		ColorArg2[2] = Current | COMPLEMENT;
		AlphaArg1[2] = CURRENT;

//		Texture[1] = <tex2>;   		
//		ColorOp[1] = Modulate;   

//		AlphaBlendEnable = true;
//		BlendOp = SUBTRACT;
//		DestBlend = ONE;
//		SrcBlend = ONE;

		ZEnable = false;   
		ZWriteEnable = false;
}
//  pass p1
//  {	
//		TextureFactor = 0xFFFFFFFF;
//		TexCoordIndex[0] = 0;
//		Texture[0] = <tex0>;        
//		ColorOp[0] = SelectArg1;
//		ColorArg1[0] = TFACTOR;
//		AlphaArg1[0] = TEXTURE | COMPLEMENT;
//		AlphaOp[0] = SelectArg1;		
//		AlphaOp[1] = disable;		
//		Texture[1] = <tex1>;   
//		TexCoordIndex[1] = 1; 
//		ColorOp[1] = BLENDCURRENTALPHA;
//		ZEnable = false;
	
//		AlphaBlendEnable = true;
//		BlendOp = Add;
//		DestBlend = SRCCOLOR;
//		SrcBlend = ZERO;

//		ZWriteEnable = false;
 //}
//  pass p2
//  {	
//		TextureFactor = 0xFFFFFFFF;
//		TexCoordIndex[0] = 0;
//		Texture[0] = <tex0>;        
//		ColorOp[0] = SelectArg1;
//		ColorArg1[0] = TFACTOR;
//		AlphaArg1[0] = TEXTURE;
//		AlphaOp[0] = SelectArg1;		
//		AlphaOp[1] = disable;		
//		Texture[1] = <tex2>;   
//		TexCoordIndex[1] = 1; 
//		ColorOp[1] = BLENDCURRENTALPHA;
//		ZEnable = false;
	
//		AlphaBlendEnable = true;
//		BlendOp = Add;
//		DestBlend = SRCCOLOR;
//		SrcBlend = ZERO;

//		ZWriteEnable = false;
 //}
 
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