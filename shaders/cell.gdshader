shader_type canvas_item;

uniform float amplitude = 0.2; // Pulse amount
uniform float speed = 2.0;     // Speed of pulsation & rotation
uniform float rotation_speed = 1.0; // How fast it spins

void fragment() {
    // Center UV to (0,0)
    vec2 uv = UV - vec2(0.5);

    // Calculate scale using sine wave
    float scale = 1.0 + sin(TIME * speed) * amplitude;
    uv /= scale;

    // Calculate rotation angle over time
    float angle = TIME * rotation_speed;
    float cos_a = cos(angle);
    float sin_a = sin(angle);

    // Apply 2D rotation matrix
    uv = mat2(vec2(cos_a, -sin_a), vec2(sin_a, cos_a)) * uv;

    // Move UV back to (0.5, 0.5) space
    uv += vec2(0.5);

    // Sample the texture and output
    COLOR = texture(TEXTURE, uv) * COLOR;
}
