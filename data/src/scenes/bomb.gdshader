shader_type spatial;
render_mode unshaded;

// source: https://godotshaders.com/shader/raymarch-in-a-box/

// VERTEX (vec3), MODELVIEW_MATRIX (vec4)

void fragment() {
	vec3 color = vec3(0.0);
	ALBEDO = color;
}