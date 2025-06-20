shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 1.0) = 0.05;
uniform float frequency : hint_range(0.1, 10.0) = 2.0;
uniform vec2 pivot = vec2(0.0, 0.0);

void vertex() {
    float pulse = sin(TIME * frequency) * amplitude;

    // Shift pivot to origin
    VERTEX -= pivot;

    // Apply scaling (squish X, stretch Y)
    //VERTEX.x *= 1.0 - pulse;
    VERTEX.y *= 1.0 + pulse;

    // Shift back
    VERTEX += pivot;
}
