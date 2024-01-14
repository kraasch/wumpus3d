shader_type spatial;

// source: https://godotshaders.com/shader/quick-example-fresnel-outline/

uniform float outline_width : hint_range(0.0, 10.0, 0.1) = 5.0;
uniform vec4 base_color : source_color = vec4(1.0, 0.2, 0.2, 0.0);

void fragment() {
	ALBEDO = vec3(1.0, 0.0, 0.0);
}