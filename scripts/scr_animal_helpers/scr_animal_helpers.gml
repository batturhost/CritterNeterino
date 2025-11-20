// --- scr_animal_helpers ---
// This script holds our "actor" functions

// ... (Keep existing Init/Hurt/Lunge/Stat functions) ...
function init_animal(_animal_object, _data, _sprite_to_use) {
    _animal_object.my_data = _data;
    _animal_object.sprite_index = _sprite_to_use;
    _animal_object.home_x = _animal_object.x;
    _animal_object.home_y = _animal_object.y;
}

function effect_play_hurt(_actor_object) {
    _actor_object.flash_alpha = 1.0;
    _actor_object.flash_color = c_white;
    _actor_object.shake_timer = 15;
}

function effect_play_lunge(_actor_object, _target_actor) {
    _actor_object.lunge_state = 1;
    var _target_x = _actor_object.home_x + ((_target_actor.x - _actor_object.x) * 0.66);
    var _target_y = _actor_object.home_y + ((_target_actor.y - _actor_object.y) * 0.66);
    _actor_object.lunge_target_x = _target_x;
    _actor_object.lunge_target_y = _target_y; 
    _actor_object.lunge_speed = 0.1; 
}

function effect_play_bite_lunge(_actor_object, _target_actor) {
    _actor_object.lunge_state = 1;
    var _target_x = _actor_object.home_x + ((_target_actor.x - _actor_object.x) * 0.85); 
    var _target_y = _actor_object.home_y + ((_target_actor.y - _actor_object.y) * 0.85);
    _actor_object.lunge_target_x = _target_x;
    _actor_object.lunge_target_y = _target_y; 
    _actor_object.lunge_speed = 0.25; 
}

function effect_play_heal_flash(_actor_object) {
    _actor_object.flash_alpha = 1.0;
    _actor_object.flash_color = c_lime;
    _actor_object.shake_timer = 0;
}

function effect_play_stat_flash(_actor_object, _type = "debuff") {
    _actor_object.flash_alpha = 1.0;
    _actor_object.shake_timer = 0;
    if (_type == "debuff") {
        _actor_object.flash_color = c_red;
    } else {
        _actor_object.flash_color = c_aqua;
    }
}

function player_has_healthy_critters() {
    for (var i = 0; i < array_length(global.PlayerData.team); i++) {
        if (global.PlayerData.team[i].hp > 0) return true;
    }
    return false;
}

// --- EXISTING VFX ---
function effect_play_ice(_actor_object) { _actor_object.vfx_type = "ice"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 45; }
function effect_play_snow(_actor_object) { _actor_object.vfx_type = "snow"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 90; }
function effect_play_sleep(_actor_object) { _actor_object.vfx_type = "sleep"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_water(_actor_object) { _actor_object.vfx_type = "water"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 45; }
function effect_play_zen(_actor_object) { _actor_object.vfx_type = "zen"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_soundwave(_actor_object) { _actor_object.vfx_type = "soundwave"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_feathers(_actor_object) { _actor_object.vfx_type = "feathers"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 45; }
function effect_play_angry(_actor_object) { _actor_object.vfx_type = "angry"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_tongue(_actor_object) { _actor_object.vfx_type = "tongue"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 30; }
function effect_play_up_arrow(_actor_object) { _actor_object.vfx_type = "up_arrow"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_tail_shed(_actor_object) { _actor_object.vfx_type = "tail_shed"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_shield(_actor_object) { _actor_object.vfx_type = "shield"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_shockwave(_actor_object) { _actor_object.vfx_type = "shockwave"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 45; }
function effect_play_bite(_actor_object) { _actor_object.vfx_type = "bite"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 20; }
function effect_play_hearts(_actor_object) { _actor_object.vfx_type = "hearts"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_mud(_actor_object, _target) { _actor_object.vfx_type = "mud"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 30; _actor_object.vfx_target_dx = _target.x - _actor_object.x; _actor_object.vfx_target_dy = _target.y - _actor_object.y; }
function effect_play_slap(_actor_object) { _actor_object.vfx_type = "slap"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 15; }
function effect_play_dive(_actor_object, _target) { _actor_object.vfx_type = "dive"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 0; _actor_object.vfx_state = 0; _actor_object.vfx_target_x = _target.x; _actor_object.vfx_target_y = _target.y; }
function effect_play_yap(_actor_object) { _actor_object.vfx_type = "yap"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 45; }
function effect_play_zoomies(_actor_object) { _actor_object.vfx_type = "zoomies"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }
function effect_play_puff(_actor_object) { _actor_object.vfx_type = "puff"; _actor_object.vfx_particles = []; _actor_object.vfx_timer = 60; }

// --- NEW: BAMBOO (Green sticks) ---
function effect_play_bamboo(_actor_object) {
    _actor_object.vfx_type = "bamboo";
    _actor_object.vfx_particles = [];
    _actor_object.vfx_timer = 45;
}

// --- NEW: LAZY (Blue Zs + Slow) ---
function effect_play_lazy(_actor_object) {
    _actor_object.vfx_type = "lazy";
    _actor_object.vfx_particles = [];
    _actor_object.vfx_timer = 60;
}

// --- NEW: ROLL (Rotation + Lunge) ---
function effect_play_roll(_actor_object, _target_actor) {
    // Trigger the physical movement
    effect_play_lunge(_actor_object, _target_actor);
    
    // Trigger the Rotation VFX logic
    _actor_object.vfx_type = "roll";
    _actor_object.vfx_particles = [];
    _actor_object.vfx_timer = 0; // Used to count up for rotation
}

// --- BATCH UPDATE: SIMPLE VFX ---
function effect_play_scratch(_actor) { effect_play_lunge(_actor, _actor); _actor.flash_alpha=1.0; _actor.flash_color = c_white; }
function effect_play_dust(_actor) { effect_play_puff(_actor); } 
function effect_play_poison(_actor) { effect_play_bite(_actor); _actor.flash_color = c_purple; }
function effect_play_coil(_actor) { _actor.flash_alpha=1.0; _actor.flash_color = c_yellow; }