shader_type canvas_item;

//const vec4 parchment_color = vec4(0.95, 0.9, 0.75, 1.0);
//uniform float grain_strength : hint_range(0.0, 1.0) = 0.1;
//uniform float vignette_strength : hint_range(0.0, 2.0) = 1.0;
//
//float rand(vec2 co) {
    //return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
//}
//
//void fragment() {
    //vec2 uv = UV;
    //
    //// Base color
    //vec4 color = texture(TEXTURE, UV);
//
    //// Add grain noise
    //float grain = rand(uv * 800.0); // Higher scale = finer noise
    //color.rgb += (grain - 0.5) * grain_strength;
//
    //// Vignette for that aged edge
    //float dist = distance(uv, vec2(0.5));
    //float vignette = smoothstep(0.6, 0.9, dist);
    //color.rgb *= 1.0 - vignette * vignette_strength;
//
    //COLOR = color;
//}
