// Sample effect file

texture tex0;

technique tec0
/*
{
	pass p0
	{
	
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
		
		ColorWriteEnable = alpha;
  		
	}

	pass p1
	{
	
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		MipFilter[0] = linear;
	
		AlphaTestEnable = false;
	      AlphaBlendEnable = true;
//	      SrcBlend = SrcAlpha;
//	      DestBlend = InvSrcAlpha;
		
		cullmode = none;
		zwriteenable = false;
		zfunc = equal;
		
		ColorWriteEnable = red| green | blue|alpha;
  		
	}

	pass p2
	{
	
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		MipFilter[0] = linear;
	
		AlphaTestEnable = false;
	      AlphaBlendEnable = true;
	      SrcBlend = SrcAlpha;
	      DestBlend = InvSrcAlpha;
		
		cullmode = cw;
		zwriteenable = false;
		zfunc = less;
		
 		
	}
	pass p3
	{
	
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		MipFilter[0] = linear;
	
		AlphaTestEnable = false;
	      AlphaBlendEnable = true;
	      SrcBlend = SrcAlpha;
	      DestBlend = InvSrcAlpha;
		
		cullmode = ccw;
//		zwriteenable = true;
		zfunc = less;
		
 		
	}

}
*/


/*
{

	pass P0
   {
  
      AlphaBlendEnable = true;
      SrcBlend = SrcAlpha;
      DestBlend = InvSrcAlpha;
      ZWriteEnable = false;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = Modulate;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] = SelectArg1;
        AlphaArg1[0] = Texture;
        AlphaArg2[0] = Diffuse;
	MipFilter[0] = linear;
      
    }
    
    pass P1
    {
      
      AlphaTestEnable = true;
      AlphaRef = 0x00000040;
      AlphaFunc = GreaterEqual;
//      ZWriteEnable = true;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = Modulate;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] = SelectArg1;
        AlphaArg1[0] = Texture;
        AlphaArg2[0] = Diffuse;
	MipFilter[0] = none;
      
    } 
}
*/
/*
{
   pass P0
   {
	AlphaBlendEnable = False;
	AlphaTestEnable = True;
	AlphaRef = 255;
	AlphaFunc = Equal;
        

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = Modulate;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] = SelectArg1;
        AlphaArg1[0] = Texture;
        AlphaArg2[0] = Diffuse;
	MipFilter[0] = none;
    }

    pass P1
    {
    	AlphaTestEnable = False;
	AlphaBlendEnable = True;
	SrcBlend = SrcAlpha;
	DestBlend = InvSrcAlpha;
	
	ZFunc = Less;
	ZWriteEnable = False;
    

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        ColorOp[0] = Modulate;
        ColorArg1[0] = Texture;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] = SelectArg1;
        AlphaArg1[0] = Texture;
        AlphaArg2[0] = Diffuse;
	MipFilter[0] = LINEAR;
   }
}
*/





{
    pass p0
    {
	// Turn lighting on and use light 0
	lighting = false;
	ZWRITEENABLE = true;

	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
        AlphaOp[0] = SelectArg1;
	MipFilter[0] = linear;
//	MinFilter[0] = LINEAR;	
//	MagFilter[0] = LINEAR;	


//	AlphaBlendEnable = false;

	AlphaTestEnable = true;
	AlphaRef = 0x00000040;
	AlphaFunc = GreaterEqual;
	
	AddressU[0] = CLAMP;
	AddressV[0] = CLAMP;
	cullmode = ccw;
    }
  
   pass p1
    {
	MipFilter[0] = LINEAR;

        BlendOp = Add;                          
  //      SrcBlend = SrcAlpha;                    
  //      DestBlend = InvSrcAlpha;             
	
	AlphaTestEnable = false;
	AlphaBlendEnable = true;
	ZWRITEENABLE = false;
    }
}

/* 
   pass P0
    {
        VertexShader = compile vs_2_0 VertScene();
        PixelShader  = compile ps_2_0 PixScene();
        
//        ZEnable = true;
		ZWRITEENABLE = true;
		AlphaTestEnable = true;
		AlphaBlendEnable = false;
		AlphaRef = 0x00000000;
		AlphaFunc = Greater;
	//	FogEnable = true;
		ColorWriteEnable = Red | Green | Blue;
    }
   
    pass P1
    {
        VertexShader = compile vs_2_0 VertScene();
        PixelShader  = compile ps_2_0 PixScene2();
//        ZEnable = TRUE;
	ZWRITEENABLE = false;
	AlphaTestEnable = FALSE;
	AlphaBlendEnable = TRUE;
	AlphaRef = 0x000000F0;
	AlphaFunc = Less;
//	FogEnable = true;
	ColorWriteEnable = Red | Green | Blue;
    }
*/