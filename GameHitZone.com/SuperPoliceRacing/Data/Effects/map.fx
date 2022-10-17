texture tex0;

texture tex1;


technique t0
{
	pass p0 
	{	
	       	Lighting = false;
		
		TexCoordIndex[0] = 0;
		Texture[0] = <tex0>;        
		TexCoordIndex[1] = 1; 
		Texture[1] = <tex1>;   		
		ColorOp[1] = Modulate;

		AlphaBlendEnable = true;
		BlendOp = SUBSTRUCT;
		DestBlend = ONE;
		SrcBlend = ONE;

    }

}