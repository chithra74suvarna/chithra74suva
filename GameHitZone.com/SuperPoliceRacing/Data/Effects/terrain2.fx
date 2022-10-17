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
		TexCoordIndex[1] = 1; 
		Texture[1] = <tex1>;   		
		ColorOp[1] = Modulate;   

//		AlphaBlendEnable = true;
//		BlendOp = Add;
//		DestBlend = ONE;
//		SrcBlend = ONE;

//		ZEnable = false;   
//		ZWriteEnable = false;
}
}
