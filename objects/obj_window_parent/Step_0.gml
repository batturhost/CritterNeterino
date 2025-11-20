// --- obj_window_parent: Step Event ---

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _click = mouse_check_button_pressed(mb_left);

// 1. Update Coordinates
window_x2 = window_x1 + window_width;
window_y2 = window_y1 + window_height;

btn_close_x1 = window_x2 - 28;
btn_close_y1 = window_y1 + 6;
btn_close_x2 = window_x2 - 6;
btn_close_y2 = window_y1 + 28;

// 2. Close Button Logic
btn_close_hover = point_in_box(_mx, _my, btn_close_x1, btn_close_y1, btn_close_x2, btn_close_y2);

if (_click && btn_close_hover) {
    instance_destroy();
    exit; 
}

// 3. Dragging Logic (Global Lock)
if (mouse_check_button_pressed(mb_left)) {
    // Only start dragging if no other window is being dragged
    if (global.dragged_window == noone) {
        // Click on Title Bar (Height 32)
        if (point_in_box(_mx, _my, window_x1, window_y1, window_x2, window_y1 + 32) && !btn_close_hover) {
            is_dragging = true;
            global.dragged_window = id; // Lock global drag
            
            // Calculate offset
            drag_dx = window_x1 - _mx;
            drag_dy = window_y1 - _my;
            
            // Bring to Front
            global.top_window_depth -= 1;
            depth = global.top_window_depth;
        }
    }
}

if (mouse_check_button_released(mb_left)) {
    is_dragging = false;
    if (global.dragged_window == id) {
        global.dragged_window = noone; // Release lock
    }
}

if (is_dragging) {
    window_x1 = _mx + drag_dx;
    window_y1 = _my + drag_dy;
}