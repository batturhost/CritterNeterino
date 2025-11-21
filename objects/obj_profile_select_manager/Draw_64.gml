// --- Draw GUI Event ---

draw_set_font(fnt_vga);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 1. Draw Background/Scanlines (Global style)
draw_set_color(c_teal);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_color(c_black); draw_set_alpha(0.15);
for(var i=0; i<display_get_gui_height(); i+=4) draw_line(0, i, display_get_gui_width(), i);
draw_set_alpha(1.0);


// 2. INHERIT PARENT (Draw Window Frame)
// Note: Parent draws the background and frame of the window itself
event_inherited();

// 3. Instructions
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(window_x1 + (window_width/2), window_y1 + 50, "Select your User Avatar:");

// 4. Draw Grid
for (var i = 0; i < array_length(avatar_list); i++) {
    var _col = i % grid_cols;
    var _row = floor(i / grid_cols);
    
    var _cx = grid_x1 + (_col * (cell_size + grid_padding));
    var _cy = grid_y1 + (_row * (cell_size + grid_padding));
    
    // Determine Frame State
    var _state = "raised";
    if (selected_index == i) _state = "sunken"; // Selected is pushed in
    
    // Draw Frame
    draw_rectangle_95(_cx, _cy, _cx + cell_size, _cy + cell_size, _state);
    
    // Draw Selection Highlight
    if (selected_index == i) {
        draw_set_color(c_navy); // Blue background for selected
        draw_rectangle(_cx + 2, _cy + 2, _cx + cell_size - 2, _cy + cell_size - 2, false);
    }
    else if (hover_index == i) {
        draw_set_color(c_white); // Slight highlight for hover
        draw_set_alpha(0.5);
        draw_rectangle(_cx + 2, _cy + 2, _cx + cell_size - 2, _cy + cell_size - 2, false);
        draw_set_alpha(1.0);
    }
    
    // Draw Sprite
    var _spr = avatar_list[i];
    var _sw = sprite_get_width(_spr);
    var _sh = sprite_get_height(_spr);
    
    // [FIX] Use a fixed max size for the icon (e.g., 64px) inside the 100px cell
    // This ensures generous padding on all sides.
    var _max_icon_size = 64; 
    var _scale = min(_max_icon_size / _sw, _max_icon_size / _sh);
    
    // Calculate strict center of the cell
    var _center_x = _cx + (cell_size / 2);
    var _center_y = _cy + (cell_size / 2);
    
    // Assuming standard GameMaker sprites default to Top-Left (0,0) origin.
    // To center them, we draw at center minus half the scaled size.
    var _draw_x = _center_x - ((_sw * _scale) / 2);
    var _draw_y = _center_y - ((_sh * _scale) / 2);
    
    // However, if the sprite asset has a centered origin, this manual offset is wrong.
    // The safest way is to use sprite_get_xoffset to compensate.
    var _x_off = sprite_get_xoffset(_spr);
    var _y_off = sprite_get_yoffset(_spr);
    
    // Re-calculate draw position assuming we pass _center_x/y to draw_sprite_ext
    // draw_sprite_ext draws at (X,Y) using the sprite's origin.
    // We want the visual center of the sprite (width/2, height/2) to be at (_center_x, _center_y).
    // So we draw at:
    // X = _center_x + (x_offset - width/2) * scale
    // Y = _center_y + (y_offset - height/2) * scale
    
    _draw_x = _center_x + (_x_off - (_sw/2)) * _scale;
    _draw_y = _center_y + (_y_off - (_sh/2)) * _scale;
    
    // Force Scissor just in case
    gpu_set_scissor(_cx + 4, _cy + 4, cell_size - 8, cell_size - 8);
    
    draw_sprite_ext(_spr, 0, _draw_x, _draw_y, _scale, _scale, 0, c_white, 1);
    
    gpu_set_scissor(0, 0, display_get_gui_width(), display_get_gui_height());
}

// 5. Draw OK Button
var _btn_state = btn_ok_hover ? "sunken" : "raised";
draw_rectangle_95(btn_ok_x1, btn_ok_y1, btn_ok_x2, btn_ok_y2, _btn_state);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(btn_ok_x1 + (btn_ok_w/2), btn_ok_y1 + (btn_ok_h/2) + 2, "FINISH");

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);