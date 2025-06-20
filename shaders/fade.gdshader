shader_type canvas_item;

void fragment() {
    float period = 2.5;
    float alpha = 0.5 * (1.0 + sin(6.2831 * TIME / period)); // 2π ≈ 6.2831

    COLOR = texture(TEXTURE, UV);
    COLOR.a *= alpha;
}