extends TurretState

var path: Array = []


func enter() -> void:
	if character.pathfinding == null:
		finished.emit(&"idle")
		return

	var random_point: Vector2 = character.global_position + Vector2(
		randf_range(-character.wander_radius.x, character.wander_radius.x),
		randf_range(-character.wander_radius.y, character.wander_radius.y)
	)
	path = character.pathfinding.get_simple_path(character.global_position, random_point)

	if path.size() <= 1:
		finished.emit(&"idle")
		return

	if character.target != null:
		character._play_animation(&"walk_alert")
	else:
		character._play_animation(&"walk")


func exit() -> void:
	path = []


func update(delta: float) -> void:
	if character._can_see_target():
		finished.emit(&"alert")
		return

	if path.is_empty():
		finished.emit(&"idle")
		return

	var next_point: Vector2 = path.front()

	while character.global_position.distance_to(next_point) < character.pathfinding_step_threshold:
		path.pop_front()
		if path.is_empty():
			finished.emit(&"idle")
			return
		next_point = path.front()

	character.velocity = (
		character.velocity
		+ character.global_position.direction_to(next_point) * character.speed * delta
	).limit_length(character.max_speed)
	character._apply_movement()
	character.body_anim.flip_h = character.velocity.x < 0


func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		&"alert":
			character._play_animation(&"walk_alert")
		&"go_normal":
			character._play_animation(&"walk")


func _handle_body_entered(body: Node2D) -> void:
	super(body)
	character._play_animation(&"alert")


func _handle_body_exited(body: Node2D) -> void:
	super(body)
	character._play_animation(&"go_normal")
