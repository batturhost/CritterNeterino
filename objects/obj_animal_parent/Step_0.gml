// --- Step Event ---

// 1. Animate the sprite manually
animation_frame = (animation_frame + animation_speed) % sprite_get_number(sprite_index);

// 2. Handle Hurt Effect (Flash)
if (flash_alpha > 0) {
    flash_alpha -= 0.05;
}

// ... (Keep all the VFX Logic same as previous, no changes needed here) ...
// (Paste lines 26 through 300 from the previous obj_animal_parent step event here if you need to completely replace the file)
// ================== VFX LOGIC ==================

// --- ICE SHARDS ---
if (vfx_type == "ice") {
    if (vfx_timer > 0) { 
        for (var k = 0; k < 4; k++) { 
            var _new_particle = {
                x: random_range(-40, 40), 
                y: random_range(-sprite_get_height(sprite_index) * my_scale * 0.8, 10), 
                speed_x: random_range(-1.5, 1.5),
                speed_y: random_range(-3.5, -1.5), 
                life: irandom_range(40, 60), 
                max_life: irandom_range(40, 60),
                scale: random_range(1.0, 2.5), 
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.y += _p.speed_y; 
        _p.x += _p.speed_x * 0.5; 
        _p.life -= 1;
        _p.scale = (_p.life / _p.max_life) * _p.scale;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- SNOW LOGIC ---
else if (vfx_type == "snow") {
    if (vfx_timer > 0) { 
        for (var k = 0; k < 10; k++) { 
            var _h = sprite_get_height(sprite_index) * my_scale;
            var _new_particle = {
                x: random_range(-20, 120), 
                y: random_range(-_h * 1.5, -_h * 0.5),
                speed_x: random_range(-3.0, -1.0), 
                speed_y: random_range(2.0, 4.0), 
                life: irandom_range(40, 70), 
                max_life: irandom_range(40, 70),
                scale: random_range(0.5, 2.0),
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.y += _p.speed_y; 
        _p.x += _p.speed_x;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- SLEEP LOGIC ---
else if (vfx_type == "sleep") {
    if (vfx_timer % 15 == 0 && vfx_timer > 0) { 
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: random_range(-10, 10), 
            y: -_h * 0.8, 
            speed_x: 1.5, 
            speed_y: -1.0, 
            life: 60, 
            max_life: 60,
            scale: 1.0, 
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.y += _p.speed_y;
        _p.scale += 0.01;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- WATER IMPACT LOGIC ---
else if (vfx_type == "water") {
    if (vfx_timer == 45) { 
        var _h = sprite_get_height(sprite_index) * my_scale;
        for (var k = 0; k < 20; k++) {
             var _angle = random_range(0, 360); 
             var _spd = random_range(4, 9); 
             var _new_particle = {
                x: 0, 
                y: -_h * 0.7, 
                speed_x: lengthdir_x(_spd, _angle), 
                speed_y: lengthdir_y(_spd, _angle), 
                life: irandom_range(20, 35), 
                max_life: 35,
                scale: random_range(0.6, 1.2),
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.y += _p.speed_y;
        _p.speed_y += 0.4; 
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- ZEN LOGIC ---
else if (vfx_type == "zen") {
    if (vfx_timer == 60) { 
        var _new_particle = {
            x: 0, y: -sprite_get_height(sprite_index) * my_scale * 0.5, 
            scale: 0.1,
            life: 60,
            max_life: 60
        };
        array_push(vfx_particles, _new_particle);
    }
    if (array_length(vfx_particles) > 0) {
        var _p = vfx_particles[0];
        _p.scale += 0.05; 
        _p.life -= 1;
        if (_p.life <= 0) array_delete(vfx_particles, 0, 1);
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- SOUND WAVE LOGIC ---
else if (vfx_type == "soundwave") {
    if (vfx_timer % 20 == 0 && vfx_timer > 0) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: 0, 
            y: -_h * 0.8, 
            scale: 0.1,
            life: 60,
            max_life: 60
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.scale += 0.05; 
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- FEATHERS LOGIC ---
else if (vfx_type == "feathers") {
    if (vfx_timer == 45) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        for (var k = 0; k < 10; k++) {
            var _new_particle = {
                x: random_range(-20, 20), 
                y: random_range(-_h, -_h * 0.5),
                speed_x: random_range(-2.0, 2.0), 
                speed_y: random_range(-1.0, 1.0), 
                life: irandom_range(40, 60), 
                max_life: 60,
                angle: random(360),
                spin: random_range(-5, 5)
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.y += _p.speed_y;
        _p.speed_y += 0.1; 
        _p.angle += _p.spin;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- ANGRY LOGIC ---
else if (vfx_type == "angry") {
    if (vfx_timer == 60) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: 20, 
            y: -_h * 0.9, 
            speed_y: -0.5, 
            life: 60, 
            max_life: 60,
            scale: 1.0
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.y += _p.speed_y;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- TONGUE LOGIC ---
else if (vfx_type == "tongue") {
    if (vfx_timer == 30) {
        var _new_particle = {
            x: 0, 
            y: -sprite_get_height(sprite_index) * my_scale * 0.5, 
            length: 0,
            max_length: 100,
            retracting: false,
            life: 30,
            max_life: 30
        };
        array_push(vfx_particles, _new_particle);
    }
    if (array_length(vfx_particles) > 0) {
        var _p = vfx_particles[0];
        if (!_p.retracting) {
            _p.length = lerp(_p.length, _p.max_length, 0.3);
            if (_p.length > _p.max_length * 0.9) _p.retracting = true;
        } else {
            _p.length = lerp(_p.length, 0, 0.3);
        }
        _p.life -= 1;
        if (_p.life <= 0) array_delete(vfx_particles, 0, 1);
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- UP ARROW LOGIC ---
else if (vfx_type == "up_arrow") {
    if (vfx_timer % 10 == 0 && vfx_timer > 0) {
         var _h = sprite_get_height(sprite_index) * my_scale;
         var _new_particle = {
            x: random_range(-20, 20), 
            y: random_range(-_h, -_h/2), 
            speed_y: -2,
            life: 40,
            max_life: 40
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.y += _p.speed_y;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- TAIL SHED LOGIC ---
else if (vfx_type == "tail_shed") {
    if (vfx_timer == 60) {
         var _new_particle = {
            x: -30, 
            y: -20, 
            speed_y: 0,
            angle: 0,
            life: 60,
            max_life: 60
        };
        array_push(vfx_particles, _new_particle);
    }
    if (array_length(vfx_particles) > 0) {
        var _p = vfx_particles[0];
        _p.y += _p.speed_y;
        _p.speed_y += 0.5; 
        _p.angle += 5; 
        _p.life -= 1;
        if (_p.life <= 0) array_delete(vfx_particles, 0, 1);
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- NEW: SHIELD LOGIC ---
else if (vfx_type == "shield") {
    // Just a timer countdown, the visual is handled in Draw
    vfx_timer--;
    if (vfx_timer <= 0) vfx_type = "none";
}

// --- NEW: SHOCKWAVE LOGIC ---
else if (vfx_type == "shockwave") {
    if (vfx_timer == 45) {
         var _new_particle = {
            x: 0, 
            y: -sprite_get_height(sprite_index) * my_scale * 0.5, 
            scale: 0.1,
            life: 45,
            max_life: 45
        };
        array_push(vfx_particles, _new_particle);
    }
    if (array_length(vfx_particles) > 0) {
        var _p = vfx_particles[0];
        _p.scale += 0.05; // Expand rapidly
        _p.life -= 1;
        if (_p.life <= 0) array_delete(vfx_particles, 0, 1);
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- NEW: BITE LOGIC ---
else if (vfx_type == "bite") {
    // Just a fast timer
    vfx_timer--;
    if (vfx_timer <= 0) vfx_type = "none";
}

// ========================================================


// --- 3. Run State Logic (UPDATED FOR SPEED) ---

if (is_fainting) {
    if (faint_scale_y > 0) {
        faint_scale_y -= 0.02;
        faint_alpha -= 0.02;   
    } else {
        faint_scale_y = 0;
        faint_alpha = 0;
    }
    
} else if (shake_timer > 0) {
    shake_timer--;
    lunge_current_x = random_range(-3, 3);
    lunge_current_y = random_range(-3, 3); 
    
} else {
    // Default speed if variable is not set (safety fallback)
    if (!variable_instance_exists(id, "lunge_speed")) lunge_speed = 0.1;
    
    switch (lunge_state) {
        case 1: // Lunge Forward
            // Use the dynamic 'lunge_speed' here!
            lunge_current_x = lerp(lunge_current_x, lunge_target_x - home_x, lunge_speed);
            lunge_current_y = lerp(lunge_current_y, lunge_target_y - home_y, lunge_speed); 
            
            if (abs(lunge_current_x - (lunge_target_x - home_x)) < 5) { 
                lunge_state = 2;
            }
            break;
        case 2: // Return Home
            lunge_current_x = lerp(lunge_current_x, 0, 0.1);
            lunge_current_y = lerp(lunge_current_y, 0, 0.1); 
            
            if (abs(lunge_current_x) < 1 && abs(lunge_current_y) < 1) {
                lunge_current_x = 0;
                lunge_current_y = 0;
                lunge_state = 0;
                lunge_speed = 0.1; // Reset to normal
            }
            break;
        default:
            lunge_current_x = 0;
            lunge_current_y = 0;
            break;
    }
}

x = home_x + lunge_current_x;
y = home_y + lunge_current_y;