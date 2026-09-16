extends PlayerState

var _elapsed: float = 0.0
var _direction: int = 1


func enter() -> void:
	_elapsed = 0.0

	_direction = character.h_movement_direction
	if _direction == 0:
		_direction = 1 if character.body_pivot.scale.x >= 0 else -1

	character.dash_cooldown_left = character.dash_cooldown
	character.body_pivot.scale.x = _direction
	character.velocity = Vector2(_direction * character.dash_speed, 0.0)
	character._play_animation(&"jump")


func exit() -> void:
	_elapsed = 0.0
	character.velocity.x = clampf(
		character.velocity.x,
		-character.h_speed_limit,
		character.h_speed_limit
	)


func handle_input(_event: InputEvent) -> void:
	return


func update(delta: float) -> void:
	character._handle_weapon_actions()

	_elapsed += delta
	character.velocity.x = _direction * character.dash_speed
	character.velocity.y = 0.0
	character._apply_movement(delta)

	if _elapsed < character.dash_duration:
		return

	character._handle_move_input(delta)
	if character.h_movement_direction != 0:
		finished.emit(&"walk")
	else:
		finished.emit(&"idle")


func _on_animation_finished(_anim_name: StringName) -> void:
	return


func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"dead")
