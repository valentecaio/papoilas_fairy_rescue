shader_type spatial;
render_mode unshaded;
uniform sampler2D disp_map;
uniform float uv_x = 0.25;

void vertex() {
    float uv_y = UV.y * 0.5;
    float disp = texture(disp_map, vec2(uv_x, uv_y)).r;
    disp = clamp(disp, 0.0, 1.0);

    if (UV.x < 1.0) {
        VERTEX += (1.0 - disp) * vec3(1.0,0.0,0.0);
    }
    else {
        VERTEX += vec3(2.0,0.0,0.0);
    }
}

void fragment() {
    float uv_y = UV.y * 0.25;
	ALBEDO = vec3(0.2, 0.2, 0.2);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
