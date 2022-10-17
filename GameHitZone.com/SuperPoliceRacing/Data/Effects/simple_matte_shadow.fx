texture tex0;
texture tex1;

technique tec0
{
    pass p0
    {
	lighting = false;
	TexCoordIndex[0] = 0;
	Texture[0] = <tex0>;
	TexCoordIndex[1] = 1;
	Texture[1] = <tex1>;
        ColorOp[1] = Modulate;
        AlphaOp[1] = Modulate;
    }
}
