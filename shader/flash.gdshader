shader_type spatial;

uniform vec4 flash_color : source_color = vec4(1.0);
uniform float intensity = 2.5;
uniform float speed = 20.0;

void fragment() {
    float blink = abs(sin(TIME * speed));
    ALBEDO = mix(vec3(0.0), flash_color.rgb, blink);
    EMISSION = flash_color.rgb * blink * intensity;
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
