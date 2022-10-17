texture tex0;

float3 lightDir1 = {0.2, -0.2, -1.0};
float3 lightDir2 = {0.2, 0.2, -1.0};
float3 lightDir3 = {-0.2, -0.2, -1.0};
float3 lightDir4 = {-0.2, 0.2, -1.0};

technique tec0
{
    pass p0
    {
      // Set up reasonable material defaults
        MaterialAmbient = {0.1, 0.1, 0.1, 1.0}; 
        MaterialDiffuse = {1.0, 1.0, 1.0, 1.0}; 
        MaterialSpecular = {0.0, 0.0, 0.0, 1.0}; 
        MaterialPower = 40.0f;

        // Set up one directional light
        LightType[0]      = DIRECTIONAL;
        LightDiffuse[0]   = {1.0, 1.0, 1.0, 1.0};
        LightSpecular[0]  = {1.0, 1.0, 1.0, 1.0}; 
        LightAmbient[0]   = {0.0, 0.0, 0.0, 1.0};
        LightDirection[0] = <lightDir1>; // Use the vector parameter defined above
        LightRange[0]     = 200.0;

	LightEnable[0] = True;

        // Set up one directional light
        LightType[1]      = DIRECTIONAL;
        LightDiffuse[1]   = {1.0, 1.0, 1.0, 1.0};
        LightSpecular[1]  = {1.0, 1.0, 1.0, 1.0}; 
        LightAmbient[1]   = {0.1, 0.1, 0.1, 1.0};
        LightDirection[1] = <lightDir2>; // Use the vector parameter defined above
        LightRange[1]     = 200.0;

	LightEnable[1] = True;

        // Set up one directional light
        LightType[2]      = DIRECTIONAL;
        LightDiffuse[2]   = {1.0, 1.0, 1.0, 1.0};
        LightSpecular[2]  = {1.0, 1.0, 1.0, 1.0}; 
        LightAmbient[2]   = {0.1, 0.1, 0.1, 1.0};
        LightDirection[2] = <lightDir3>; // Use the vector parameter defined above
        LightRange[2]     = 200.0;

	LightEnable[2] = True;

        // Set up one directional light
        LightType[3]      = DIRECTIONAL;
        LightDiffuse[3]   = {1.0, 1.0, 1.0, 1.0};
        LightSpecular[3]  = {1.0, 1.0, 1.0, 1.0}; 
        LightAmbient[3]   = {0.1, 0.1, 0.1, 1.0};
        LightDirection[3] = <lightDir4>; // Use the vector parameter defined above
        LightRange[3]     = 200.0;

	LightEnable[3] = True;


	DiffuseMaterialSource = material;	
	Ambient = {0.3, 0.3, 0.3, 1.0}; 
        
	// Turn lighting on and use light 0

	LightEnable[4] = false;
	LightEnable[5] = false;
	LightEnable[6] = false;
	LightEnable[7] = false;

	TexCoordIndex[0] = 0;
        // Set up texture stage 0
	Texture[0] = <tex0>;
        
        // Disable texture stage 1
    }
}
