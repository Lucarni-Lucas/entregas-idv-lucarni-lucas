extends TurretState


func enter() -> void:
	character.velocity = Vector2.ZERO
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0

	if character.target != null:
		character._play_animation(&"die_alert")
	else:
		character._play_animation(&"die")


func update(_delta: float) -> void:
	return


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"die" || anim_name == &"die_alert":
		character._remove.call_deferred()


func handle_event(_event: StringName, _value = null) -> void:
	return
