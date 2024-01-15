shader_type spatial;

uniform sampler2D noise_a : repeat_enable;
uniform sampler2D noise_b : repeat_enable;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform  vec2 scroll_a = vec2(0.05, 0.05);
uniform  vec2 scroll_b = vec2(-0.05, -0.05);
uniform float distortion_strength : hint_range(-1, 1) = 0.2;
uniform vec4 tone_color : source_color = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 top_color : source_color = vec4(0.7, 1.0, 0.7, 1.0);
uniform float light_start : hint_range(0.0, 1.0) = 0.275;
uniform float light_end   : hint_range(0.0, 1.0) = 0.4;
void fragment() {
	float depth = texture(noise_a, UV + scroll_a * TIME).r
	* texture(noise_b, UV + scroll_b * TIME).r;
	vec4 screen_col = texture(screen_texture, SCREEN_UV + distortion_strength * vec2(depth));
	vec4 top_light = smoothstep(light_start, light_end, depth) * top_color;
	ALBEDO = (screen_col * tone_color + top_light).xyz;
}
