shader_type spatial;

uniform sampler2D noise : repeat_enable;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform  vec2 scroll = vec2(0.05, 0.05);
uniform vec3 tone_color : source_color;

void fragment() {
	vec4 noise_col = texture(noise, UV + scroll * TIME);
	vec4 screen_col = texture(screen_texture, SCREEN_UV);
	ALBEDO = noise_col.xyz * tone_color;
}
