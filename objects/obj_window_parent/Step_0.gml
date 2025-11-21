// --- obj_window_parent: Step Event ---

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _click = mouse_check_button_pressed(mb_left);

// ================== OPENING ANIMATION LOGIC ==================
if (anim_state == 0) {
    // INITIALIZE: Capture the desired final state set by the Child Object
    final_x = window_x1;
    final_y = window_y1;
    final_w = window_width;
    final_h = window_height;
    
    // Set Start State (Icon position approx by mouse, small size)
    start_x = _mx;
    start_y = _my;
    start_w = 10;
    start_h = 10;
    
    // Apply Start State immediately
    window_x1 = start_x;
    window_y1 = start_y;
    window_width = start_w;
    window_height = start_h;
    
    anim_state = 1; // Start animating
}
else if (anim_state == 1) {
    // ANIMATE
    anim_timer++;
    var _t = anim_timer / anim_duration;
    
    // Simple Ease Out Quart/Quint for "pop" feel, or just Lerp
    // Let's use a simple smooth step or lerp
    _t = clamp(_t, 0, 1);
    // Ease Out Expo
    var _ease = 1 - power(2, -10 * _t);
    
    window_x1 = lerp(start_x, final_x, _ease);
    window_y1 = lerp(start_y, final_y, _ease);
    window_width = lerp(start_w, final_w, _ease);
    window_height = lerp(start_h, final_h, _ease);
    
    if (anim_timer >= anim_duration) {
        // SNAP TO FINAL
        window_x1 = final_x;
        window_y1 = final_y;
        window_width = final_w;
        window_height = final_h;
        anim_state = 2; // Done
    }
}

// =============================================================

// 1. Update Coordinates (Recalculate x2/y2 based on animating x1/w)
window_x2 = window_x1 + window_width;
window_y2 = window_y1 + window_height;

// ... (Rest of existing dragging/close logic)

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