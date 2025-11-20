// --- Alarm 0: Battle State Timer ---

switch (current_state) {
    case BATTLE_STATE.WAIT_FOR_START:
        current_state = BATTLE_STATE.PLAYER_TURN;
        current_menu = MENU.MAIN;
        menu_focus = 0;
        break;
        
    case BATTLE_STATE.WAIT_FOR_PLAYER_MOVE:
        // Check for fainted enemy
        if (enemy_critter_data.hp <= 0) {
            current_state = BATTLE_STATE.ENEMY_FAINT;
            alarm[0] = 60;
        } else {
            // Trigger passive damage or proceed
            current_state = BATTLE_STATE.PLAYER_POST_TURN_DAMAGE;
            event_user(0); // Or just jump to logic:
            if (player_critter_data.glitch_timer > 0) {
                 player_critter_data.glitch_timer--;
                 current_state = BATTLE_STATE.PLAYER_POST_TURN_DAMAGE;
            } else {
                 current_state = BATTLE_STATE.ENEMY_TURN;
            }
        }
        break;
        
    case BATTLE_STATE.WAIT_FOR_ENEMY_MOVE:
        // Check for fainted player
        if (player_critter_data.hp <= 0) {
            current_state = BATTLE_STATE.PLAYER_FAINT;
            alarm[0] = 60;
        } else {
            current_state = BATTLE_STATE.ENEMY_POST_TURN_DAMAGE;
            if (enemy_critter_data.glitch_timer > 0) {
                 enemy_critter_data.glitch_timer--;
                 current_state = BATTLE_STATE.ENEMY_POST_TURN_DAMAGE;
            } else {
                 current_state = BATTLE_STATE.PLAYER_TURN;
            }
        }
        break;
        
    case BATTLE_STATE.WAIT_FOR_FAINT:
        if (enemy_critter_data.hp <= 0) {
            // YOU WIN
            if (is_casual) {
                download_start_percent = 0;
                download_end_percent = 100; // Should calculate based on catch rate, simplified for now
                download_current_percent = 0;
                download_filename = enemy_critter_data.animal_name + ".critter";
                download_sprite = enemy_critter_data.sprite_idle;
                current_state = BATTLE_STATE.WIN_DOWNLOAD_PROGRESS;
            } else {
                current_state = BATTLE_STATE.WIN_XP_GAIN;
                alarm[0] = 30;
            }
        } else {
            // YOU LOSE (or Swap)
            if (player_has_healthy_critters()) {
                is_force_swapping = true;
                current_state = BATTLE_STATE.PLAYER_TURN;
                current_menu = MENU.TEAM; // Force open team menu
                battle_log_text = "Choose your next critter!";
            } else {
                current_state = BATTLE_STATE.LOSE;
            }
        }
        break;

    case BATTLE_STATE.PLAYER_SWAP_IN:
        // Logic to actually swap the critter data
        var _new_critter = global.PlayerData.team[swap_target_index];
        
        // 1. Remove old actor
        instance_destroy(player_actor);
        
        // 2. Update Data
        player_critter_data = _new_critter;
        // Update buttons for new moves
        var _btn_w = 175; var _btn_h = 30; var _btn_gutter = 10;
        var _log_y1 = window_y1 + (window_height * 0.8);
        var _btn_base_x = window_x2 - (_btn_w * 2) - (_btn_gutter * 2);
        var _btn_base_y = _log_y1 + 15;
        
        btn_move_menu = [
            [_btn_base_x, _btn_base_y, _btn_base_x + _btn_w, _btn_base_y + _btn_h, player_critter_data.moves[0].move_name],
            [_btn_base_x + _btn_w + _btn_gutter, _btn_base_y, _btn_base_x + _btn_w * 2 + _btn_gutter, _btn_base_y + _btn_h, player_critter_data.moves[1].move_name], 
            [_btn_base_x, _btn_base_y + _btn_h + _btn_gutter, _btn_base_x + _btn_w, _btn_base_y + _btn_h * 2 + _btn_gutter, player_critter_data.moves[2].move_name],
            [_btn_base_x + _btn_w + _btn_gutter, _btn_base_y + _btn_h + _btn_gutter, _btn_base_x + _btn_w * 2 + _btn_gutter, _btn_base_y + _btn_h * 2 + _btn_gutter, "BACK"]
        ];
        
        // 3. Spawn new actor
        var _layer_id = layer_get_id("Instances");
        // === FIX: Use calculated position (re-calc here to be safe) ===
        var _px = window_x1 + (window_width * 0.3);
        var _py = window_y1 + (window_height * 0.7);
        player_actor = instance_create_layer(_px, _py, _layer_id, obj_player_critter);
        
        init_animal(player_actor, player_critter_data, player_critter_data.sprite_idle_back);
        player_actor.my_scale = 0.33 * 1.30;
        if (player_critter_data.animal_name == "Capybara" || player_critter_data.animal_name == "Pomeranian") {
            player_actor.my_scale *= 0.8;
        }
        
        battle_log_text = "Go! " + player_critter_data.nickname + "!";
        current_state = BATTLE_STATE.PLAYER_TURN;
        current_menu = MENU.MAIN;
        break;
        
    case BATTLE_STATE.WIN_DOWNLOAD_COMPLETE:
        current_state = BATTLE_STATE.WIN_XP_GAIN; // Proceed to XP after download
        alarm[0] = 60;
        break;
        
    case BATTLE_STATE.WIN_CHECK_LEVEL:
        // === FIX: Use 'next_level_xp' instead of 'xp_to_next' ===
        if (player_critter_data.xp >= player_critter_data.next_level_xp) {
             player_critter_data.level += 1;
             player_critter_data.xp -= player_critter_data.next_level_xp;
             
             // Recalculate next threshold (Simple curve)
             player_critter_data.next_level_xp = power(player_critter_data.level, 3); // or standard curve from helper
             
             // Recalculate stats
             recalculate_stats(player_critter_data);
             
             battle_log_text = player_critter_data.nickname + " grew to Level " + string(player_critter_data.level) + "!";
             current_state = BATTLE_STATE.WIN_LEVEL_UP_MSG;
             alarm[0] = 120;
        } else {
            current_state = BATTLE_STATE.WIN_END;
            alarm[0] = 30;
        }
        break;
        
    case BATTLE_STATE.WIN_LEVEL_UP_MSG:
        // Check again if we leveled up multiple times
        if (player_critter_data.xp >= player_critter_data.next_level_xp) {
            current_state = BATTLE_STATE.WIN_CHECK_LEVEL;
            alarm[0] = 10;
        } else {
            current_state = BATTLE_STATE.WIN_END;
            alarm[0] = 30;
        }
        break;
        
    // Passive Damage Loops
    case BATTLE_STATE.PLAYER_POST_TURN_DAMAGE:
         current_state = BATTLE_STATE.ENEMY_TURN;
         break;
    case BATTLE_STATE.ENEMY_POST_TURN_DAMAGE:
         current_state = BATTLE_STATE.PLAYER_TURN;
         break;
}