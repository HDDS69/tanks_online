shader_type canvas_item;

uniform vec4 shadow_color: 100;
uniform float shadow_offset_x;
uniform float shadow_offset_y;

void fragment() {
    vec2 shadow_offset = vec2(shadow_offset_x, shadow_offset_y);
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Получение цвета пикселя тени
    vec4 shadow_tex_color = texture(TEXTURE, UV + shadow_offset);
    
    // Установка тени на основе цвета текстуры
    if (shadow_tex_color.a > 0.0) {
        COLOR = shadow_color * shadow_tex_color.a;
    } else {
        COLOR = tex_color;
    }
}
