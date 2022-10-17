texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
         SpecularEnable = true;
				lighting = false;
					TexCoordIndex[0] = 0;
        // Set up texture stage 0
					Texture[0] = <tex0>;
					ColorOp[0] = Modulate;
					ColorArg2[0] = Texture;
					ColorArg1[0] = Diffuse;
						
					TexCoordIndex[1] = 0;
        // Set up texture stage 1
					Texture[1] = <tex1>;
					ColorOp[1] = BLENDDIFFUSEALPHA;
					ColorArg2[1] = Texture;
					ColorArg1[1] = Current;
       
    }
    pass p1
    {
        SpecularEnable = false;
				lighting = true;
       // Set up texture stage 0
					ColorOp[0] = SelectArg1;
					ColorArg1[0] = Diffuse;
					ColorOp[1] = Subtract;
					ColorArg1[1] = Current;
					ColorArg2[1] = tfactor;
					TextureFactor = 0xff808080;
					AlphaBlendEnable = true;
					BlendOp = Add;
					SrcBlend = SrcColor;
					DestBlend = InvSrcColor;

						       
    }
 }
