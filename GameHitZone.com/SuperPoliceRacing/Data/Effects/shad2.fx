// Sample effect file

technique tec0
{
    pass p0
    {
	// Turn lighting on and use light 0
        Lighting = false;

        ColorOp[0] = SelectArg2;
	ZWriteEnable = false;
	ZEnable = false;
///	CullMode = none;
    }
}
