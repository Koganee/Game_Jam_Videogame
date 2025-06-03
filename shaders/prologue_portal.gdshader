shader_type canvas_item;
render_mode unshaded, blend_add;

uniform float time;
uniform sampler2D swirl_texture;

void fragment() {
    // Convert UV from [0,1] to [-1,1] centered coordinates
    vec2 uv = UV * 2.0 - 1.0;
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    
    // Animate swirl
    angle += TIME * 5.5;
    vec2 swirl_uv = vec2(cos(angle), sin(angle)) * radius;
    swirl_uv = swirl_uv * 0.5 + 0.5; // Back to [0,1]

    // Sample texture
    vec4 tex = texture(swirl_texture, swirl_uv);
    
    // Apply purple tint
    vec3 purple_tint = vec3(0.6, 0.2, 1.0);
    vec3 color = tex.rgb * purple_tint;

    // Output final color
    COLOR = vec4(color * 5.0, tex.a); // EMISSION-style brightness, with alpha
}
