shader_type canvas_item;
uniform vec4 modulate : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec4 mcolor = vec4(modulate.rgb, 0.0);
    COLOR = texture(TEXTURE, UV)+mcolor;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
