shader_type spatial;

uniform float outline_width : hint_range(0.0, 10.0, 0.1) = 5.0;
uniform vec4 base_color : source_color = vec4(1.0, 0.2, 0.2, 0.0);

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	float speed = 0.4 * random(UV);
	float glow = abs(mod(TIME * speed, 2.0) - 1.0);
	ALBEDO = vec3(0.0, glow * 0.1 + 0.1 , 0.0);
}