@abstract
class_name TurretState extends AbstractState

var character: EnemyTurret


func exit() -> void:
	return


func handle_input(_event: InputEvent) -> void:
	return


func _on_animation_finished(_anim_name: StringName) -> void:
	return


func handle_event(event: StringName, value = null) -> void:
	match event:
		&"body_entered":
			_handle_body_entered(value)
		&"body_exited":
			_handle_body_exited(value)


func _handle_body_entered(body: Node2D) -> void:
	if character.target == null:
		character.target = body


func _handle_body_exited(body: Node2D) -> void:
	if body == character.target:
		character.target = null
