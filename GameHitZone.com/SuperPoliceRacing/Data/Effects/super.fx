// Sample effect file
technique tec0
{
    pass p0
    {
        Lighting = false;
	
	ColorOp[0] = SelectArg2;
        ColorArg2[0] = Diffuse;
        AlphaOp[0] =Disable;


	AlphaBlendEnable = true;
	BlendOp = Add;
	DestBlend = ONE;
	SrcBlend = ONE;
    }
}
