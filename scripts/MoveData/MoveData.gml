// --- MoveData Script ---
// Constructor for moves

function MoveData(_name, _atk, _acc, _desc, _effect_desc, _type, _element = "BEAST", _effect_power = 0) constructor {
    move_name = _name;
    atk = _atk;
    accuracy = _acc;
    description = _desc;
    effect_description = _effect_desc;
    move_type = _type;     // DAMAGE, HEAL, STAT_BUFF, STAT_DEBUFF
    element = _element;    // BEAST, NATURE, HYDRO, AERO, TOXIC
    effect_power = _effect_power;
}

// Enum for Move Types
enum MOVE_TYPE {
    DAMAGE,
    HEAL,
    STAT_BUFF,
    STAT_DEBUFF
}