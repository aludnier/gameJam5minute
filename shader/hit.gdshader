shader_type spatial;

uniform vec4 hit_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float emission_strength = 1.5;

void fragment() {
    ALBEDO = hit_color.rgb;
    EMISSION = hit_color.rgb * emission_strength;
    ALPHA = hit_color.a;
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
