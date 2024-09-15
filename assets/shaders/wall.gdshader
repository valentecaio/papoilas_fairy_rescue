shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D depth_tex:hint_depth_texture;

void fragment() {
	// Called for every pixel the material is visible on.
    float depth = texture(depth_tex, SCREEN_UV).r;
    depth = PROJECTION_MATRIX[3][2] / (depth + PROJECTION_MATRIX[2][2]);
    if (depth < 15.0){
        discard;
    }

    //ALBEDO = COLOR(77, 80, 84);

    METALLIC = 0.0;
    ROUGHNESS = 0.01;
    ALBEDO = vec3(0.2, 0.2, 0.2);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
