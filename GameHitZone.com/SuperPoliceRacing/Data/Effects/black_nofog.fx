texture tex0;

technique tec0
{
    pass p0
    {
	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;        
         Lighting = false;
	FogEnable = false;
//	CULLMODE = NONE;
    }
}
