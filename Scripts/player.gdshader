shader_type canvas_item;

uniform vec4 color: source_color;
uniform float multiplier = 0.2;
uniform float softness = 3.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float value = distance(UV, vec2(0.5));
	COLOR = vec4(color.rgb, smoothstep(multiplier, softness, value));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
