@tool
extends Node

@onready var action_name_label: Label = %ActionName
@onready var action_label: Label = %ActionLabel
@onready var action_texture_button: TextureRect = %ActionTextureButton

@export var action: StringName
@export var action_name: String :
	set(value):
		action_name = value
		if has_node("%ActionName"):
			action_name_label = %ActionName
			action_name_label.text = value

@export var mouse_buttons_events: Array[int]
@export var mouse_buttons_textures: Array[Texture]
@export var mouse_button_default_texture: Texture
@export var keys_textures_map: Dictionary[Key, Texture]


func _ready() -> void:
	if !Engine.is_editor_hint():
		GameState.input_map_changed.connect(_refresh_inputs)
		_refresh_inputs()


func _refresh_inputs() -> void:
	action_label.text = ""
	action_label.hide()
	action_texture_button.hide()
	
	var event: InputEvent = InputMap.action_get_events(action)[0]
	
	if event is InputEventMouseButton:
		action_texture_button.show()
		var id: int = mouse_buttons_events.find(event.button_index)
		if id != -1:
			action_texture_button.texture = mouse_buttons_textures[id]
		else:
			action_texture_button.texture = mouse_button_default_texture
	elif (
		event is InputEventKey &&
		keys_textures_map.has((event as InputEventKey).keycode) ||
		keys_textures_map.has((event as InputEventKey).physical_keycode)
	):
		action_texture_button.show()
		var event_key: InputEventKey = event as InputEventKey
		if keys_textures_map.has(event_key.keycode):
			action_texture_button.texture = keys_textures_map[event_key.keycode]
		else:
			action_texture_button.texture = keys_textures_map[event_key.physical_keycode]
	else:
		action_label.show()
		action_label.text = event.as_text()
