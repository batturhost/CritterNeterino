// --- scr_critter_config.gml ---
// Use this file to control the size of specific critters in battle.
// Returns a multiplier (e.g., 1.0 = normal, 0.5 = half size, 2.0 = double size)

function get_critter_scale_config(_animal_name) {
    switch (_animal_name) {
        
        // --- BIG CRITTERS (Scale Down) ---
        case "Capybara":    return 0.8;
        case "Pomeranian":  return 0.8;
        
        // --- SMALL CRITTERS (Scale Down/Up) ---
        case "Rabbit":      return 0.7; // <--- Adjust this number to change Rabbit size
        
        // Add new cases here as needed:
        // case "Dragon": return 1.5;
        
        // --- DEFAULT (Everyone else) ---
        default: return 1.0;
    }
}