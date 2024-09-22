shader_type spatial;
//render_mode unshaded;
uniform float current_center_uv;
uniform float uv_margin = 0.05;
uniform sampler2D albedo_map;
uniform sampler2D disp_map;

void vertex() {
    float disp = texture(disp_map, UV).r;
    disp = clamp(disp, 0.0, 1.0);
    VERTEX += disp * NORMAL;
}

bool should_clip(float uv_x){
    float left_margin = current_center_uv - uv_margin;
    float right_margin = current_center_uv + uv_margin;
    if (left_margin >= 0.0 && right_margin <= 1.0){
        return uv_x > left_margin && uv_x < right_margin;
    }
    else if (left_margin < 0.0) {
        return uv_x < right_margin || uv_x > (1.0 + left_margin);
    }
    else { // right_margin > 1.0
        return uv_x > left_margin || uv_x < (right_margin - 1.0);
    }
}

void fragment(){
    if (should_clip(UV.x)){
        discard;
    }
    else {
        ALBEDO = 0.2 * texture(albedo_map, UV).xyz;
    }
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
