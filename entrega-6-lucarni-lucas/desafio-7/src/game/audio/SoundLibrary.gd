class_name SoundLibrary

const PLAYER_JUMP: Array = [
	preload("res://assets/sound/sfx/jump/12_human_jump_1.wav"),
	preload("res://assets/sound/sfx/jump/12_human_jump_2.wav"),
	preload("res://assets/sound/sfx/jump/12_human_jump_3.wav"),
]

const PLAYER_LAND: Array = [
	preload("res://assets/sound/sfx/jump/13_human_jump_land_1.wav"),
	preload("res://assets/sound/sfx/jump/13_human_jump_land_2.wav"),
]

const PLAYER_DASH: Array = [
	preload("res://assets/sound/sfx/movement/15_human_dash_1.wav"),
	preload("res://assets/sound/sfx/movement/15_human_dash_2.wav"),
]

const PLAYER_STEP: Array = [
	preload("res://assets/sound/sfx/movement/16_human_walk_stone_1.wav"),
	preload("res://assets/sound/sfx/movement/16_human_walk_stone_2.wav"),
	preload("res://assets/sound/sfx/movement/16_human_walk_stone_3.wav"),
]

const PLAYER_DAMAGE: Array = [
	preload("res://assets/sound/sfx/player/11_human_damage_1.wav"),
	preload("res://assets/sound/sfx/player/11_human_damage_2.wav"),
	preload("res://assets/sound/sfx/player/11_human_damage_3.wav"),
]

const PLAYER_DEATH: AudioStream = preload("res://assets/sound/sfx/player/14_human_death_spin.wav")

const SWORD_SWING: Array = [
	preload("res://assets/sound/sfx/attacks/sword/07_human_atk_sword_1.wav"),
	preload("res://assets/sound/sfx/attacks/sword/07_human_atk_sword_2.wav"),
	preload("res://assets/sound/sfx/attacks/sword/07_human_atk_sword_3.wav"),
]

const SWORD_HIT: Array = [
	preload("res://assets/sound/sfx/attacks/sword/26_sword_hit_1.wav"),
	preload("res://assets/sound/sfx/attacks/sword/26_sword_hit_2.wav"),
	preload("res://assets/sound/sfx/attacks/sword/26_sword_hit_3.wav"),
]

const STAFF_BOLT: AudioStream = preload("res://assets/sound/sfx/attacks/staff/10_human_special_atk_1.wav")
const STAFF_WIND: AudioStream = preload("res://assets/sound/sfx/attacks/staff/shockwave.ogg")
const STAFF_FIRE: AudioStream = preload("res://assets/sound/sfx/attacks/staff/explosion.wav")

const STAFF_BY_TYPE: Array = [STAFF_BOLT, STAFF_WIND, STAFF_FIRE]

const ENEMY_ALERT: AudioStream = preload("res://assets/sound/sfx/enemies/Hiss.wav")
const ENEMY_ATTACK: AudioStream = preload("res://assets/sound/sfx/enemies/20_orc_special_atk.wav")
const ENEMY_DEATH: AudioStream = preload("res://assets/sound/sfx/enemies/24_orc_death_spin.wav")

const ENEMY_DAMAGE: Array = [
	preload("res://assets/sound/sfx/enemies/21_orc_damage_1.wav"),
	preload("res://assets/sound/sfx/enemies/21_orc_damage_2.wav"),
	preload("res://assets/sound/sfx/enemies/21_orc_damage_3.wav"),
]

const UI_CLICK: AudioStream = preload("res://assets/sound/UI/Minimalist1.ogg")
const UI_HOVER: AudioStream = preload("res://assets/sound/UI/Minimalist2.ogg")

const MUSIC_MENU: AudioStream = preload("res://assets/sound/bgm/Ambience 1.ogg")
const MUSIC_LEVEL: AudioStream = preload("res://assets/sound/bgm/Action 1.ogg")
const MUSIC_GAME_OVER: AudioStream = preload("res://assets/sound/bgm/gameOver.ogg")
