extends GenericStateMachine

@export var character: EnemyTurret


func _setup() -> void:
	if character == null:
		character = get_parent() as EnemyTurret
	if character == null:
		printerr("%s: character is not defined!" % name)
		return

	character.hit.connect(notify_hit)
	for state: TurretState in states_list:
		state.character = character


func notify_hit(_amount: int = 1) -> void:
	if current_state == null || current_state.state_id == &"die":
		return
	_change_state(&"die")


func _on_detection_area_body_entered(body: Node2D) -> void:
	if current_state == null:
		return
	current_state.handle_event(&"body_entered", body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	if current_state == null:
		return
	current_state.handle_event(&"body_exited", body)


func _on_body_animation_finished() -> void:
	_on_animation_finished(character.get_current_animation())
