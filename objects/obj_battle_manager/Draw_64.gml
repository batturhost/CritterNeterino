// --- Draw GUI Event ---

if (!variable_instance_exists(id, "btn_main_menu")) {
    exit; 
}

draw_set_font(fnt_vga);

// Check if we are in a special "Download" UI state
if (current_state == BATTLE_STATE.WIN_DOWNLOAD_PROGRESS || current_state == BATTLE_STATE.WIN_DOWNLOAD_COMPLETE)
{
    // ... (Keep existing Download UI code here if you want, or move it to another script too!)
    // For this refactor I will keep the Download UI inline as it's unique state logic,
    // but the Battle UI below is heavily optimized.
    #region // --- DOWNLOAD UI ---
    draw_set_color(c_teal);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_scanlines_95(0, 0, display_get_gui_width(), display_get_gui_height());
    
    var _win_w = 440; var _win_h = 400;
    var _win_x1 = (display_get_gui_width() / 2) - (_win_w / 2);
    var _win_y1 = (display_get_gui_height() / 2) - (_win_h / 2);
    var _win_x2 = _win_x1 + _win_w; var _win_y2 = _win_y1 + _win_h;

    draw_rectangle_95(_win_x1, _win_y1, _win_x2, _win_y2, "raised");
    draw_set_color(c_navy);
    draw_rectangle(_win_x1 + 2, _win_y1 + 2, _win_x2 - 2, _win_y1 + 32, false); 
    draw_set_color(c_white);
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_set_font(fnt_vga);
    draw_text(_win_x1 + (_win_w / 2), _win_y1 + 17, "File Acquisition");

    if (current_state == BATTLE_STATE.WIN_DOWNLOAD_PROGRESS) {
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_set_color(c_black);
        draw_text(_win_x1 + (_win_w / 2), _win_y1 + 100, "Downloading Critter-File...");
        draw_text(_win_x1 + (_win_w / 2), _win_y1 + 120, download_filename);
        
        var _bar_x1 = _win_x1 + (_win_w / 2) - (download_bar_w / 2);
        var _bar_y1 = _win_y1 + (_win_h / 2);
        var _bar_x2 = _bar_x1 + download_bar_w;
        var _bar_y2 = _bar_y1 + download_bar_h;
        draw_rectangle_95(_bar_x1, _bar_y1, _bar_x2, _bar_y2, "sunken");
        
        var _fill_width = (download_bar_w - 4) * (download_current_percent / 100);
        draw_set_color(c_navy);
        draw_rectangle(_bar_x1 + 2, _bar_y1 + 2, _bar_x1 + 2 + _fill_width, _bar_y2 - 2, false);
        draw_set_color(c_white);
        draw_set_halign(fa_center); draw_set_valign(fa_middle);
        draw_text(_bar_x1 + (download_bar_w / 2), _bar_y1 + (download_bar_h / 2), string(floor(download_current_percent)) + "%");
        draw_set_color(c_black);
        draw_set_halign(fa_center); draw_set_valign(fa_top);
        draw_text(_win_x1 + (_win_w / 2), _win_y2 - 40, "[Downloading...]");
    } else { 
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_color(c_black);
        var _text = "Critter-File Download Complete!";
        if (download_end_percent >= 100) {
            _text = "Download Complete! Critter Acquired!";
        }
        draw_text(_win_x1 + (_win_w / 2), _win_y1 + 60, _text);
        var _sprite_w = sprite_get_width(download_sprite);
        var _sprite_h = sprite_get_height(download_sprite);
        var _box_w = 250; var _box_h = 200;
        var _scale = min(_box_w / _sprite_w, _box_h / _sprite_h);
        var _sprite_x = _win_x1 + (_win_w / 2);
        var _sprite_y = _win_y1 + 180 + ((_sprite_h / 2) * _scale);
        draw_sprite_ext(download_sprite, 0, _sprite_x, _sprite_y, _scale, _scale, 0, c_white, 1);
        draw_text(_win_x1 + (_win_w / 2), _win_y2 - 120, "You acquired data for:");
        draw_set_color(c_yellow);
        draw_text(_win_x1 + (_win_w / 2), _win_y2 - 100, enemy_critter_data.animal_name);
    }
    #endregion
}
else
{
    // --- DRAW THE NORMAL BATTLE UI ---
    
    // 1. Window Frame
    draw_rectangle_95(window_x1, window_y1, window_x2, window_y2, "raised");

    // 2. Battle Viewport
    draw_set_color(c_teal); 
    var _inner_x = window_x1 + 2;
    var _inner_y = window_y1 + 32; 
    var _inner_w = (window_x2 - 2) - _inner_x;
    var _inner_h = (window_y2 - 2) - _inner_y;
    
    gpu_set_scissor(_inner_x, _inner_y, _inner_w, _inner_h);
    draw_rectangle(_inner_x, _inner_y, _inner_x + _inner_w, _inner_y + _inner_h, false);
    draw_scanlines_95(_inner_x, _inner_y, _inner_x + _inner_w, _inner_y + _inner_h);
    gpu_set_scissor(0, 0, display_get_gui_width(), display_get_gui_height()); 
    
    // Title Bar
    draw_set_color(c_navy);
    draw_rectangle(window_x1 + 2, window_y1 + 2, window_x2 - 2, window_y1 + 32, false); 
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_vga);
    draw_text(window_x1 + (window_width / 2), window_y1 + 17, "CNet_Browser.exe - [BATTLE]");
    draw_set_halign(fa_left);

    // --- 3. Draw Actors using Helper ---
    var sprite_y_offset = -25;
    draw_battle_actor(enemy_actor, enemy_critter_data, sprite_y_offset);
    draw_battle_actor(player_actor, player_critter_data, sprite_y_offset);
    
    // --- 4. Draw Battle Log Box ---
    var _log_y1 = window_y1 + (window_height * 0.8);
    var _log_y2 = window_y2 - 5;
    draw_rectangle_95(window_x1 + 5, _log_y1, window_x2 - 5, _log_y2, "sunken");

    // --- 5. Draw Battle Log Text ---
    draw_set_font(fnt_vga);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    
    if (current_state == BATTLE_STATE.PLAYER_TURN && (current_menu == MENU.FIGHT || current_menu == MENU.TEAM)) {
        // Hide log
    } else {
        draw_text(window_x1 + 15, _log_y1 + 10, battle_log_text);
    }

    // --- 6. Info Boxes ---
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    // Enemy Box
    draw_rectangle_95(info_enemy_x1, info_enemy_y1, info_enemy_x2, info_enemy_y2, "raised");
    draw_set_color(c_black);
    draw_text(info_enemy_x1 + 10, info_enemy_y1 + 8, current_opponent_data.name); 
    draw_set_halign(fa_right);
    draw_text(info_enemy_x2 - 10, info_enemy_y1 + 8, "Lv. " + string(enemy_critter_data.level));
    draw_set_halign(fa_left);
    
    var _e_hp_perc = enemy_critter_data.hp / enemy_critter_data.max_hp;
    var _e_bar_x1 = info_enemy_x1 + 10; var _e_bar_y1 = info_enemy_y1 + 40;
    var _e_bar_x2 = info_enemy_x2 - 10;
    var _e_bar_y2 = info_enemy_y1 + 60;
    draw_rectangle_95(_e_bar_x1, _e_bar_y1, _e_bar_x2, _e_bar_y2, "sunken"); 
    draw_set_color(c_green);
    draw_rectangle(_e_bar_x1 + 2, _e_bar_y1 + 2, _e_bar_x1 + 2 + ((_e_bar_x2 - _e_bar_x1 - 4) * _e_hp_perc), _e_bar_y2 - 2, false);
    // Player Box
    draw_rectangle_95(info_player_x1, info_player_y1, info_player_x2, info_player_y2, "raised");
    draw_set_color(c_black);
    draw_text(info_player_x1 + 10, info_player_y1 + 8, player_critter_data.nickname); 
    draw_set_halign(fa_right);
    draw_text(info_player_x2 - 10, info_player_y1 + 8, "Lv. " + string(player_critter_data.level));
    draw_set_halign(fa_left);
    
    var _p_hp_perc = player_critter_data.hp / player_critter_data.max_hp;
    var _p_bar_x1 = info_player_x1 + 10; var _p_bar_y1 = info_player_y1 + 40;
    var _p_bar_x2 = info_player_x2 - 10;
    var _p_bar_y2 = info_player_y1 + 60;
    draw_rectangle_95(_p_bar_x1, _p_bar_y1, _p_bar_x2, _p_bar_y2, "sunken"); 
    draw_set_color(c_green);
    draw_rectangle(_p_bar_x1 + 2, _p_bar_y1 + 2, _p_bar_x1 + 2 + ((_p_bar_x2 - _p_bar_x1 - 4) * _p_hp_perc), _p_bar_y2 - 2, false);

    // --- 7. DRAW THE BATTLE UI (BUTTONS) ---
    draw_set_color(c_white);
    if (current_state == BATTLE_STATE.PLAYER_TURN) {
        draw_set_font(fnt_vga);
        
        switch (current_menu) {
            case MENU.MAIN:
                draw_battle_menu_buttons(btn_main_menu, menu_focus);
                break;
                
            case MENU.FIGHT:
                // Draw buttons with PP gray-out logic
                draw_battle_menu_buttons(btn_move_menu, menu_focus, player_critter_data.move_pp);
                
                // Draw Info Panel if hovering a valid move
                if (menu_focus >= 0 && menu_focus < array_length(player_critter_data.moves) && menu_focus != 3) {
                    var _move = player_critter_data.moves[menu_focus];
                    var _cur_pp = player_critter_data.move_pp[menu_focus];
                    
                    // Calculate Position (Left of buttons)
                    var _info_w = 250; var _info_h = 80;
                    var _info_x1 = window_x1 + 25; 
                    var _info_y1 = _log_y1 + 15;
                    
                    draw_move_info_panel(_info_x1, _info_y1, _info_w, _info_h, _move, _cur_pp);
                }
                break;
                
            case MENU.TEAM:
                // --- TEAM MENU DRAW ---
                draw_rectangle_95(window_x1 + 5, _log_y1, window_x2 - 5, window_y2 - 5, "raised");
                var _team_size = array_length(global.PlayerData.team);
                for (var i = 0; i < 6; i++) {
                    var _btn = btn_team_layout[i];
                    var _state = (menu_focus == i) ? "sunken" : "raised";
                    draw_rectangle_95(_btn[0], _btn[1], _btn[2], _btn[3], _state);
                    if (i < _team_size) {
                        var _critter = global.PlayerData.team[i];
                        if (_critter.hp <= 0 || _critter == player_critter_data) {
                            draw_set_color(c_dkgray);
                        } else {
                            draw_set_color(c_black);
                        }
                        draw_set_halign(fa_left);
                        draw_set_valign(fa_top);
                        var _sprite = _critter.sprite_idle;
                        var _frame_w = 64; var _frame_h = 64;
                        var _frame_x1 = _btn[0] + 10;
                        var _frame_y1 = _btn[1] + 8;
                        var _frame_x2 = _frame_x1 + _frame_w; var _frame_y2 = _frame_y1 + _frame_h;
                        draw_rectangle_95(_frame_x1, _frame_y1, _frame_x2, _frame_y2, "sunken");
                        var _scale = min((_frame_w - 8) / sprite_get_width(_sprite), (_frame_h - 8) / sprite_get_height(_sprite));
                        var _icon_x = _frame_x1 + (_frame_w / 2);
                        var _icon_y_center = _frame_y1 + (_frame_h / 2);
                        var _icon_draw_y = _icon_y_center + ((sprite_get_height(_sprite)/2) * _scale);
                        gpu_set_scissor(_frame_x1 + 2, _frame_y1 + 2, _frame_w - 4, _frame_h - 4);
                        draw_sprite_ext(_sprite, 0, _icon_x, _icon_draw_y, _scale, _scale, 0, c_white, 1);
                        gpu_set_scissor(0, 0, display_get_gui_width(), display_get_gui_height());
                        var _text_x = _frame_x2 + 10;
                        draw_text(_text_x, _btn[1] + 10, _critter.nickname);
                        draw_text(_text_x, _btn[1] + 30, "Lv. " + string(_critter.level));
                        var _hp_perc = _critter.hp / _critter.max_hp;
                        var _hp_bar_x1 = _text_x; var _hp_bar_y1 = _btn[1] + 55; var _hp_bar_w = 100; var _hp_bar_h = 10;
                        draw_rectangle_95(_hp_bar_x1, _hp_bar_y1, _hp_bar_x1 + _hp_bar_w, _hp_bar_y1 + _hp_bar_h, "sunken");
                        draw_set_color(c_green);
                        draw_rectangle(_hp_bar_x1 + 2, _hp_bar_y1 + 2, _hp_bar_x1 + 2 + ((_hp_bar_w - 4) * _hp_perc), _hp_bar_y1 + _hp_bar_h - 2, false);
                        draw_set_color(c_black);
                        draw_set_halign(fa_right);
                        draw_text(_btn[2] - 10, _btn[1] + 55, string(_critter.hp) + "/" + string(_critter.max_hp));
                    }
                }
                var _cancel_btn = btn_team_layout[6];
                var _cancel_state = (menu_focus == 6) ? "sunken" : "raised";
                draw_rectangle_95(_cancel_btn[0], _cancel_btn[1], _cancel_btn[2], _cancel_btn[3], _cancel_state);
                draw_set_color(c_black);
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
                var _cancel_w = _cancel_btn[2] - _cancel_btn[0];
                var _cancel_h = _cancel_btn[3] - _cancel_btn[1];
                draw_text(_cancel_btn[0] + (_cancel_w / 2), _cancel_btn[1] + (_cancel_h / 2), "CANCEL");
                break;
        }
    }
}

// --- 9. Reset Draw Settings ---
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);