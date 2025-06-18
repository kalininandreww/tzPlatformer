shader_type canvas_item;
render_mode unshaded;
uniform vec4 blinkColor: source_color;
uniform float blinkIntetnsity = 0;
void fragment() {
    vec4 color = texture(TEXTURE, UV);
    color = mix(color, blinkColor, blinkIntetnsity*color.a);

    COLOR = color;
}