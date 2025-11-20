// --- Step Event ---

// 1. Animate the sprite manually
animation_frame = (animation_frame + animation_speed) % sprite_get_number(sprite_index);

// 2. Handle Hurt Effect (Flash)
if (flash_alpha > 0) {
    flash_alpha -= 0.05;
}

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

// --- SHIELD LOGIC ---
else if (vfx_type == "shield") {
    vfx_timer--;
    if (vfx_timer <= 0) vfx_type = "none";
}

// --- SHOCKWAVE LOGIC ---
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

// --- BITE LOGIC ---
else if (vfx_type == "bite") {
    vfx_timer--;
    if (vfx_timer <= 0) vfx_type = "none";
}

// --- HEARTS LOGIC ---
else if (vfx_type == "hearts") {
    if (vfx_timer % 10 == 0 && vfx_timer > 0) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: random_range(-20, 20), 
            y: -_h * 0.5, 
            speed_y: -1.5, // Float up
            life: 50, 
            max_life: 50,
            scale: 0.5
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

// --- MUD LOGIC ---
else if (vfx_type == "mud") {
    if (vfx_timer == 30) { // Spawn 3 mud globs
        for(var k=0; k<3; k++) {
             var _new_particle = {
                x: 0, 
                y: -20, 
                // Calculate velocity to hit target in approx 20 frames
                speed_x: (vfx_target_dx / 20) + random_range(-1, 1),
                speed_y: (vfx_target_dy / 20) - 5 + random_range(-1, 1), // Arc up (-5)
                gravity: 0.5,
                life: 20,
                max_life: 20,
                scale: random_range(0.8, 1.2)
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.y += _p.speed_y;
        _p.speed_y += _p.gravity; // Apply gravity
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- SLAP LOGIC ---
else if (vfx_type == "slap") {
    vfx_timer--;
    if (vfx_timer <= 0) vfx_type = "none";
}

// --- DIVE LOGIC ---
else if (vfx_type == "dive") {
    switch (vfx_state) {
        case 0: // Rise Up
            y -= 15; // Rise quickly
            if (y < home_y - 300) { // Go off screen
                vfx_state = 1;
                vfx_timer = 15; // Hover/Wait for a moment
            }
            break;
            
        case 1: // Dive Down
            if (vfx_timer > 0) {
                vfx_timer--; // Wait
            } else {
                // Move towards target fast!
                var _dir = point_direction(x, y, vfx_target_x, vfx_target_y);
                var _dist = point_distance(x, y, vfx_target_x, vfx_target_y);
                
                var _speed = 40; // Very fast dive
                x += lengthdir_x(_speed, _dir);
                y += lengthdir_y(_speed, _dir);
                
                if (_dist < _speed) {
                    vfx_state = 2;
                    vfx_timer = 30; // Wait at target briefly (optional)
                }
            }
            break;
            
        case 2: // Return Home (Reset)
            x = home_x;
            y = home_y;
            vfx_type = "none";
            break;
    }
}

// --- YAP LOGIC ---
else if (vfx_type == "yap") {
    if (vfx_timer % 10 == 0 && vfx_timer > 0) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: 20, 
            y: -_h * 0.6, 
            scale: 0.5,
            life: 30, 
            max_life: 30
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.scale += 0.1; // Expand fast
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- ZOOMIES LOGIC ---
else if (vfx_type == "zoomies") {
    if (vfx_timer > 0) {
        var _shake = (sin(vfx_timer) * 30); // Oscillate
        x = home_x + _shake;
        
        // Spawn speed lines
        if (vfx_timer % 5 == 0) {
            var _h = sprite_get_height(sprite_index) * my_scale;
            var _new_particle = {
                x: random_range(-30, 30), 
                y: random_range(-_h, 0),
                speed_x: -10, // Fly backward
                life: 10,
                max_life: 10
            };
            array_push(vfx_particles, _new_particle);
        }
    } else {
        x = home_x; // Reset
    }
    
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    
    vfx_timer--;
    if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- PUFF LOGIC ---
else if (vfx_type == "puff") {
    if (vfx_timer % 5 == 0 && vfx_timer > 0) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        for (var k = 0; k < 3; k++) {
            var _new_particle = {
                x: random_range(-30, 30), 
                y: random_range(-_h * 0.8, -_h * 0.2),
                scale: 0.2,
                life: 20, 
                max_life: 20
            };
            array_push(vfx_particles, _new_particle);
        }
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

// --- BAMBOO LOGIC (Falling Stalks) ---
else if (vfx_type == "bamboo") {
    if (vfx_timer == 45) {
        var _h = sprite_get_height(sprite_index) * my_scale;
        for (var k = 0; k < 5; k++) {
            var _new_particle = {
                x: random_range(-30, 30), 
                y: random_range(-_h, -20),
                speed_y: random_range(2, 4),
                angle: 0,
                rot_speed: random_range(-5, 5),
                life: 45, max_life: 45
            };
            array_push(vfx_particles, _new_particle);
        }
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.y += _p.speed_y;
        _p.angle += _p.rot_speed;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--; if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- LAZY LOGIC (Blue Zs) ---
else if (vfx_type == "lazy") {
    if (vfx_timer % 20 == 0 && vfx_timer > 0) { 
        var _h = sprite_get_height(sprite_index) * my_scale;
        var _new_particle = {
            x: random_range(-10, 10), 
            y: -_h * 0.8, 
            speed_x: 0.5, 
            speed_y: -0.5, // Slower float than Sleep
            life: 60, max_life: 60, scale: 1.0, 
        };
        array_push(vfx_particles, _new_particle);
    }
    for (var i = array_length(vfx_particles) - 1; i >= 0; i--) {
        var _p = vfx_particles[i];
        _p.x += _p.speed_x;
        _p.y += _p.speed_y;
        _p.scale += 0.005;
        _p.life -= 1;
        if (_p.life <= 0) { array_delete(vfx_particles, i, 1); i--; }
    }
    vfx_timer--; if (vfx_timer <= 0 && array_length(vfx_particles) == 0) vfx_type = "none";
}

// --- ROLL LOGIC (Rotation timer only) ---
else if (vfx_type == "roll") {
    vfx_timer++; // Count UP for rotation calculation
    
    // We check the 'lunge_state' variable (which is managed below) to know when to stop
    if (lunge_state == 0) {
        vfx_type = "none";
        vfx_timer = 0;
    }
}

// ========================================================


// --- 3. Run State Logic (UPDATED) ---
if (is_fainting) {
    if (faint_scale_y > 0) {
        faint_scale_y -= 0.02; faint_alpha -= 0.02;   
    } else {
        faint_scale_y = 0; faint_alpha = 0;
    }
} else if (shake_timer > 0) {
    shake_timer--;
    lunge_current_x = random_range(-3, 3);
    lunge_current_y = random_range(-3, 3); 
} else {
    if (!variable_instance_exists(id, "lunge_speed")) lunge_speed = 0.1;
    
    // Don't override position if doing a complex movement like Dive or Zoomies
    if (vfx_type != "dive" && vfx_type != "zoomies") {
        switch (lunge_state) {
            case 1: // Lunge Forward
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
                    lunge_speed = 0.1; // Reset to default
                }
                break;
            default:
                lunge_current_x = 0;
                lunge_current_y = 0;
                break;
        }
        x = home_x + lunge_current_x;
        y = home_y + lunge_current_y;
    }
}