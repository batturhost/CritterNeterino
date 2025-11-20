// --- GameDatabase Script ---
// This function builds the entire Bestiary and Moveset

function init_database() {
    
    // ========================================================================
    // 1. DEFINE MOVES (The "Move Pool")
    // ========================================================================
    
    // --- BASIC / SHARED (MUST BE GLOBAL FOR CHECKS) ---
    global.GENERIC_MOVE_LUNGE = new MoveData("Lunge", 30, 100, "A basic physical lunge.", "A simple lunge.", MOVE_TYPE.DAMAGE);
    global.GENERIC_MOVE_AGITATE = new MoveData("Agitate", 0, 100, "The critter looks agitated.", "Lowers enemy defense.", MOVE_TYPE.STAT_DEBUFF, -1);
    global.MOVE_SYSTEM_CALL = new MoveData("System_Call", 0, 100, "Corrupts data. [RISKY]", "Applies 'Glitched' status.", MOVE_TYPE.STAT_BUFF, 99);

    // --- ARCTIC FOX ---
    var m_ice_pounce = new MoveData("Ice Pounce", 55, 95, "A freezing leap.", "Deals massive damage.", MOVE_TYPE.DAMAGE);
    var m_snow_cloak = new MoveData("Snow Cloak", 0, 100, "Hides in snow.", "Raises user's defense.", MOVE_TYPE.STAT_BUFF, 1);

    // --- CAPYBARA ---
    var m_nap       = new MoveData("Take a Nap", 0, 100, "Heals 50 HP.", "Restores HP.", MOVE_TYPE.HEAL, 50);
    var m_hydro     = new MoveData("Hydro Headbutt", 45, 100, "A wet headbutt.", "Deals water damage.", MOVE_TYPE.DAMAGE);
    var m_zen       = new MoveData("Zen Barrier", 0, 100, "Meditates calmly.", "Raises defense.", MOVE_TYPE.STAT_BUFF, 1);

    // --- GOOSE ---
    var m_honk      = new MoveData("HONK", 0, 100, "A terrifying noise.", "Lowers enemy defense.", MOVE_TYPE.STAT_DEBUFF, -1);
    var m_wing      = new MoveData("Wing Smack", 45, 100, "A violent flap.", "Strikes with wings.", MOVE_TYPE.DAMAGE);
    var m_hiss      = new MoveData("Hiss", 0, 100, "An angry hiss.", "Lowers enemy attack.", MOVE_TYPE.STAT_DEBUFF, -1);

    // --- AXOLOTL ---
    var m_regen     = new MoveData("Regenerate", 0, 100, "Regrows cells.", "Heals 50 HP.", MOVE_TYPE.HEAL, 50);
    var m_gill      = new MoveData("Gill Slap", 40, 100, "A squishy slap.", "A quick physical attack.", MOVE_TYPE.DAMAGE);
    var m_mud       = new MoveData("Mud Shot", 20, 95, "Fling mud.", "Damage + Lowers Speed.", MOVE_TYPE.DAMAGE); 

    // --- POMERANIAN (UPDATED) ---
    var m_yap       = new MoveData("Yap", 0, 100, "An annoying bark.", "Lowers enemy attack.", MOVE_TYPE.STAT_DEBUFF, -1);
    var m_zoom      = new MoveData("Zoomies", 0, 100, "Runs in circles.", "Sharply raises speed.", MOVE_TYPE.STAT_BUFF, 2);
    // REPLACED FLUFF PUFF WITH ATTACK
    var m_pom_strike = new MoveData("Pom-Pom Strike", 50, 100, "A fluffy barrage.", "Rapid strikes.", MOVE_TYPE.DAMAGE);

    // --- GECKO ---
    var m_tongue    = new MoveData("Sticky Tongue", 40, 100, "A long lash.", "A fast strike with a tongue.", MOVE_TYPE.DAMAGE);
    var m_climb     = new MoveData("Wall Climb", 0, 100, "Climbs the screen.", "Raises user's speed.", MOVE_TYPE.STAT_BUFF, 1);
    var m_shed      = new MoveData("Tail Shed", 0, 100, "Drops its tail.", "Sharply raises defense.", MOVE_TYPE.STAT_BUFF, 2);

    // --- BOX TURTLE ---
    var m_shell     = new MoveData("Shell Bash", 50, 100, "Rams with shell.", "A heavy physical strike.", MOVE_TYPE.DAMAGE);
    var m_withdraw  = new MoveData("Withdraw", 0, 100, "Retracts into shell.", "Sharply raises defense.", MOVE_TYPE.STAT_BUFF, 2);
    var m_snap      = new MoveData("Snap", 40, 100, "A quick bite.", "A fast snapping attack.", MOVE_TYPE.DAMAGE);

    // --- PANDA ---
    var m_roll      = new MoveData("Playful Roll", 40, 100, "A clumsy roll.", "A strong physical attack.", MOVE_TYPE.DAMAGE);
    var m_bamboo    = new MoveData("Bamboo Bite", 45, 100, "Chomp.", "A strong bite.", MOVE_TYPE.DAMAGE);
    
    // --- CAT ---
    var m_scratch   = new MoveData("Scratch", 40, 100, "A fast scratch.", "High-speed attack.", MOVE_TYPE.DAMAGE);
    var m_pounce    = new MoveData("Pounce", 45, 90, "Leaps at foe.", "Strong attack.", MOVE_TYPE.DAMAGE);
    
    // --- CHINCHILLA ---
    var m_dust      = new MoveData("Dust Bath", 0, 100, "Rolls in ash.", "Raises defense.", MOVE_TYPE.STAT_BUFF, 1);
    
    // --- SNAKE ---
    var m_poison    = new MoveData("Poison Bite", 45, 100, "Venomous.", "Strong toxic attack.", MOVE_TYPE.DAMAGE);
    var m_coil      = new MoveData("Coil", 0, 100, "Tightens muscles.", "Raises Attack.", MOVE_TYPE.STAT_BUFF, 1);
    
    // --- GENERIC FILLERS FOR OTHERS ---
    var m_tackle    = new MoveData("Tackle", 35, 100, "Full body slam.", "Physical damage.", MOVE_TYPE.DAMAGE);
    var m_growl     = new MoveData("Growl", 0, 100, "Intimidate.", "Lowers Attack.", MOVE_TYPE.STAT_DEBUFF, -1);


    // ========================================================================
    // 2. DEFINE THE BESTIARY
    // ========================================================================
    global.bestiary = {};

    // --- 1. Arctic Fox ---
    global.bestiary.arctic_fox = new AnimalData("Arctic Fox", 75, 115, 60, 145, 5, spr_arctic_fox_idle, spr_arctic_fox_idle_back, spr_arctic_fox_idle, 
        [ global.GENERIC_MOVE_LUNGE, m_snow_cloak, m_ice_pounce ], 
        "Native to the Arctic. Fur turns white in winter.", "Avg. Size: 3.5 kg");

    // --- 2. Capybara ---
    global.bestiary.capybara = new AnimalData("Capybara", 190, 10, 140, 20, 5, spr_capybara_idle, spr_capybara_idle_back, spr_capybara_idle, 
        [ m_hydro, m_zen, m_nap ], 
        "Large, calm semi-aquatic rodent.", "Avg. Size: 45 kg");

    // --- 3. Goose ---
    global.bestiary.goose = new AnimalData("Goose", 100, 70, 70, 70, 5, spr_goose_idle, spr_goose_idle_back, spr_goose_idle, 
        [ m_wing, m_hiss, m_honk ], 
        "Aggressive waterfowl.", "Avg. Size: 4.0 kg");

    // --- 4. Axolotl ---
    global.bestiary.axolotl = new AnimalData("Axolotl", 150, 50, 100, 40, 5, spr_axolotl_idle, spr_axolotl_idle_back, spr_axolotl_idle, 
        [ m_mud, m_regen, m_gill ], 
        "Neotenic salamander that regenerates limbs.", "Avg. Size: 0.2 kg");

    // --- 5. Pomeranian (UPDATED) ---
    global.bestiary.pomeranian = new AnimalData("Pomeranian", 70, 90, 60, 170, 5, spr_pomeranian_idle, spr_pomeranian_idle_back, spr_pomeranian_idle, 
        [ m_yap, m_zoom, m_pom_strike ], 
        "Small dog with a fluffy coat.", "Avg. Size: 2.5 kg");

    // --- 6. Gecko ---
    global.bestiary.gecko = new AnimalData("Gecko", 80, 70, 70, 160, 5, spr_gecko_idle, spr_gecko_idle_back, spr_gecko_idle, 
        [ m_tongue, m_climb, m_shed ], 
        "Lizard with sticky toe pads.", "Avg. Size: 0.05 kg");

    // --- 7. Box Turtle ---
    global.bestiary.box_turtle = new AnimalData("Box Turtle", 120, 40, 200, 20, 5, spr_box_turtle_idle, spr_box_turtle_idle_back, spr_box_turtle_idle, 
        [ m_shell, m_withdraw, m_snap ], 
        "Turtle with a hinged domed shell.", "Avg. Size: 0.5 kg");
        
    // --- 8. Panda ---
    global.bestiary.panda = new AnimalData("Panda", 160, 90, 120, 40, 5, spr_panda_idle, spr_panda_idle_back, spr_panda_idle, 
        [ global.GENERIC_MOVE_LUNGE, m_bamboo, m_roll ], 
        "Large bear native to China.", "Avg. Size: 100 kg");
        
    // --- 9. Cat ---
    global.bestiary.cat = new AnimalData("Cat", 90, 110, 80, 160, 5, spr_cat_idle, spr_cat_idle_back, spr_cat_idle, 
        [ global.GENERIC_MOVE_LUNGE, global.GENERIC_MOVE_AGITATE, m_scratch ], 
        "Small carnivorous mammal.", "Avg. Size: 4.5 kg");
        
    // --- 10. Chinchilla ---
    global.bestiary.chinchilla = new AnimalData("Chinchilla", 70, 60, 80, 190, 5, spr_chinchilla_idle, spr_chinchilla_idle_back, spr_chinchilla_idle, 
        [ global.GENERIC_MOVE_LUNGE, m_dust, global.GENERIC_MOVE_AGITATE ], 
        "Rodent with incredibly soft fur.", "Avg. Size: 0.6 kg");
        
    // --- 11. Snake ---
    global.bestiary.snake = new AnimalData("Snake", 80, 140, 70, 140, 5, spr_snake_idle, spr_snake_idle_back, spr_snake_idle, 
        [ global.GENERIC_MOVE_LUNGE, m_coil, m_poison ], 
        "Legless carnivorous reptile.", "Avg. Size: Varies");

    // --- 12. Desert Rain Frog ---
    global.bestiary.desert_rain_frog = new AnimalData("Desert Rain Frog", 100, 40, 80, 30, 5, spr_desert_rain_frog_idle, spr_desert_rain_frog_idle_back, spr_desert_rain_frog_idle, 
        [ m_tackle, global.GENERIC_MOVE_AGITATE, m_growl ], "Small burrowing frog.", "Avg. Size: 0.01 kg");

    // --- 13. Snub-Nosed Monkey ---
    global.bestiary.snub_nosed_monkey = new AnimalData("Snub-Nosed Monkey", 100, 110, 80, 130, 5, spr_snub_nosed_monkey_idle, spr_snub_nosed_monkey_idle_back, spr_snub_nosed_monkey_idle, 
        [ m_tackle, global.GENERIC_MOVE_AGITATE, m_scratch ], "Old World monkey.", "Avg. Size: 10 kg");

    // --- 14. Harp Seal ---
    global.bestiary.harp_seal = new AnimalData("Harp Seal", 170, 70, 110, 60, 5, spr_harp_seal_idle, spr_harp_seal_idle_back, spr_harp_seal_idle, 
        [ m_hydro, m_nap, m_tackle ], "Earless seal.", "Avg. Size: 140 kg");

    // --- 15. Hedgehog ---
    global.bestiary.hedgehog = new AnimalData("Hedgehog", 120, 70, 150, 60, 5, spr_hedgehog_idle, spr_hedgehog_idle_back, spr_hedgehog_idle, 
        [ m_tackle, m_withdraw, global.GENERIC_MOVE_AGITATE ], "Spiny mammal.", "Avg. Size: 0.8 kg");

    // --- 16. Koala ---
    global.bestiary.koala = new AnimalData("Koala", 160, 60, 110, 30, 5, spr_koala_idle, spr_koala_idle_back, spr_koala_idle, 
        [ m_nap, global.GENERIC_MOVE_AGITATE, m_tackle ], "Arboreal marsupial.", "Avg. Size: 9 kg");

    // --- 17. Meerkat ---
    global.bestiary.meerkat = new AnimalData("Meerkat", 70, 120, 60, 160, 5, spr_meerkat_idle, spr_meerkat_idle_back, spr_meerkat_idle, 
        [ m_tackle, global.GENERIC_MOVE_AGITATE, m_scratch ], "Small mongoose.", "Avg. Size: 0.7 kg");

    // --- 18. Otter ---
    global.bestiary.otter = new AnimalData("Otter", 90, 100, 80, 140, 5, spr_otter_idle, spr_otter_idle_back, spr_otter_idle, 
        [ m_hydro, m_tackle, global.GENERIC_MOVE_AGITATE ], "Semiaquatic mammal.", "Avg. Size: 10 kg");

    // --- 19. Penguin ---
    global.bestiary.penguin = new AnimalData("Penguin", 140, 80, 110, 80, 5, spr_penguin_idle, spr_penguin_idle_back, spr_penguin_idle, 
        [ m_hydro, m_tackle, m_nap ], "Flightless bird.", "Avg. Size: 15 kg");

    // --- 20. Rabbit ---
    global.bestiary.rabbit = new AnimalData("Rabbit", 70, 70, 60, 200, 5, spr_rabbit_idle, spr_rabbit_idle_back, spr_rabbit_idle, 
        [ m_tackle, m_zoom, global.GENERIC_MOVE_AGITATE ], "Small mammal with long ears.", "Avg. Size: 1.5 kg");

    // --- 21. Raccoon ---
    global.bestiary.raccoon = new AnimalData("Raccoon", 100, 100, 100, 100, 5, spr_raccoon_idle, spr_raccoon_idle_back, spr_raccoon_idle, 
        [ m_tackle, global.GENERIC_MOVE_AGITATE, m_scratch ], "Dexterous mammal.", "Avg. Size: 7 kg");

    // --- 22. Red Panda ---
    global.bestiary.red_panda = new AnimalData("Red Panda", 110, 90, 80, 120, 5, spr_red_panda_idle, spr_red_panda_idle_back, spr_red_panda_idle, 
        [ m_tackle, m_bamboo, m_nap ], "Arboreal mammal.", "Avg.Size: 5 kg");

    // --- 23. Sable ---
    global.bestiary.sable = new AnimalData("Sable", 80, 110, 70, 170, 5, spr_sable_idle, spr_sable_idle_back, spr_sable_idle, 
        [ m_tackle, m_scratch, global.GENERIC_MOVE_AGITATE ], "Prized for fur.", "Avg. Size: 1.3 kg");

    // --- 24. Sugar Glider ---
    global.bestiary.sugar_glider = new AnimalData("Sugar Glider", 70, 80, 60, 190, 5, spr_sugar_glider_idle, spr_sugar_glider_idle_back, spr_sugar_glider_idle, 
        [ m_tackle, m_zoom, global.GENERIC_MOVE_AGITATE ], "Nocturnal possum.", "Avg. Size: 0.12 kg");
}