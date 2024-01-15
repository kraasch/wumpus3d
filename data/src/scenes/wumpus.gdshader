// source: https://godotshaders.com/shader/rain-and-snow-with-parallax-scrolling-effect/

shader_type spatial;

uniform float rain_amount = 200.0;
uniform float near_rain_length : hint_range(0.01, 1.0) = 0.2;
uniform float far_rain_length : hint_range(0.01, 1.0) = 0.1;
uniform float near_rain_width : hint_range(0.1, 1.0) = 1.0;
uniform float far_rain_width : hint_range(0.1, 1.0) = 0.5;
uniform float near_rain_transparency : hint_range(0.1, 1.0) = 1.0;
uniform float far_rain_transparency : hint_range(0.1, 1.0) = 0.5;
// Replace the below reference to source_color with hint_color if you are using a version of Godot before 4.0.
uniform vec4 rain_color : source_color = vec4(0.8, 0.8, 0.8, 1.0);
uniform float base_rain_speed : hint_range(0.1, 1.0) = 0.5;
uniform float additional_rain_speed : hint_range(0.1, 1.0) = 0.5;
uniform float slant : hint_range(-1.0, 1.0) = 0.2;

void fragment() {
// To control the rainfall from your program comment out the below line and add a new uniform above as:
// uniform float time = 10000.0;
// Then update the time uniform from your _physics_process function by adding delta. You can then pause the rainfall by not changing the time uniform.
	float time = 10000.0 + TIME;

// Uncomment the following line if you are applying the shader to a TextureRect and using a version of Godot before 4.0.
//	COLOR = texture(TEXTURE,UV);

	vec2 uv = vec2(0.0);
	float remainder = mod(UV.x - UV.y * slant, 1.0 / rain_amount);
	uv.x = (UV.x - UV.y * slant) - remainder;
	float rn = fract(sin(uv.x * rain_amount));
	uv.y = fract((UV.y + rn));

// Blurred trail. Works well for rain:
//	COLOR = mix(COLOR, rain_color, smoothstep(1.0 - (far_rain_length + (near_rain_length - far_rain_length) * rn), 1.0, fract(uv.y - time * (base_rain_speed + additional_rain_speed * rn))) * (far_rain_transparency + (near_rain_transparency - far_rain_transparency) * rn) * step(remainder * rain_amount, far_rain_width + (near_rain_width - far_rain_width) * rn));

// No trail. Works well for snow:

	float f1 = step(1.0 - (far_rain_length + (near_rain_length - far_rain_length) * rn), fract(uv.y - time * (base_rain_speed + additional_rain_speed * rn)));
	float f2 = far_rain_transparency + (near_rain_transparency - far_rain_transparency) * rn;
	float f3 = step(remainder * rain_amount, far_rain_width + (near_rain_width - far_rain_width) * rn);

	ALBEDO = vec3(0.0);
	ALBEDO = mix(vec4(ALBEDO, 1.0), rain_color, f1 * f2 * f3).xyz;
}
