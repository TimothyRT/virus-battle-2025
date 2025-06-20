shader_type canvas_item;

uniform float hurt_strength : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    // Blend red color based on hurt_strength
    vec4 hurt_color = vec4(1.0, 0.0, 0.0, tex_color.a); // red with alpha
    COLOR = mix(tex_color, hurt_color, hurt_strength);
}