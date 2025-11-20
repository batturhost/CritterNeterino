// --- obj_window_parent: Create Event ---

// 1. Default Window Properties (Children can override these)
window_width = 400;
window_height = 300;
window_title = "New Window";

// Position (Center by default)
window_x1 = (display_get_gui_width() / 2) - (window_width / 2);
window_y1 = (display_get_gui_height() / 2) - (window_height / 2);
window_x2 = window_x1 + window_width;
window_y2 = window_y1 + window_height;

// 2. State Variables
is_dragging = false;
drag_dx = 0;
drag_dy = 0;

// 3. UI Elements
btn_close_hover = false;
// We calculate these in Step so they follow the window
btn_close_x1 = 0; btn_close_y1 = 0; btn_close_x2 = 0; btn_close_y2 = 0;

// 4. Colors (Aero / XP Style defaults)
col_title_bar_active = c_navy;
col_title_bar_inactive = c_dkgray; // Optional: if you want inactive states later
col_bg = c_teal; // The classic background color
use_scanlines = true;