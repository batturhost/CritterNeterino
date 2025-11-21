// --- Create Event ---

// 1. INHERIT PARENT
event_inherited();

// FIX: Explicitly initialize is_dragging to prevent crash if parent init fails or lags
if (!variable_instance_exists(id, "is_dragging")) {
    is_dragging = false;
}

// 2. Window Properties
window_width = 500;
window_height = 550; // [FIX] Increased further from 520 to 550
window_title = "User Profile Setup";

// Recalculate Position
window_x1 = (display_get_gui_width() / 2) - (window_width / 2);
window_y1 = (display_get_gui_height() / 2) - (window_height / 2);
window_x2 = window_x1 + window_width;
window_y2 = window_y1 + window_height;

// 3. Avatar List
avatar_list = [
    spr_avatar_user_default, 
    spr_avatar_user_01, 
    spr_avatar_user_02, 
    spr_avatar_user_03,
    spr_avatar_user_default, 
    spr_avatar_user_01, 
    spr_avatar_user_02, 
    spr_avatar_user_03,
    spr_avatar_user_default 
];

// 4. Grid Layout
grid_cols = 3;
grid_rows = 3;
cell_size = 100;
grid_padding = 20;

// Calculate Grid Start Position (Centered in Window)
grid_w = (grid_cols * cell_size) + ((grid_cols - 1) * grid_padding);
grid_h = (grid_rows * cell_size) + ((grid_rows - 1) * grid_padding);

grid_x1 = window_x1 + (window_width - grid_w) / 2;
grid_y1 = window_y1 + 80; 

// 5. Selection State
selected_index = 0;
hover_index = -1;

// 6. OK Button
btn_ok_w = 120;
btn_ok_h = 35;
btn_ok_x1 = window_x1 + (window_width / 2) - (btn_ok_w / 2);
// [FIX] Position relative to grid bottom with more padding (+60 instead of +40)
btn_ok_y1 = grid_y1 + grid_h + 60; 
btn_ok_x2 = btn_ok_x1 + btn_ok_w;
btn_ok_y2 = btn_ok_y1 + btn_ok_h;
btn_ok_hover = false;