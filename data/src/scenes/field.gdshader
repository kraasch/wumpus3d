shader_type spatial;

uniform vec3 bg_color = vec3(0.3, 0.3, 1.0);
uniform vec3 beam_color = vec3(0.2, 0.2, 1.0);


void fragment() {
	vec2 uv = UV;
	vec3 color = bg_color;
	if (
		uv.x > 0.6 || uv.x < 0.4 || 
		uv.y > 0.9 || uv.y < 0.6
		) {
    	color = beam_color;
	}
	ALBEDO = color;
}