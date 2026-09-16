extends TurretState


func enter() -> void:
	character.velocity = Vector2.ZERO
	fire()


func fire() -> void:
	character._fire()
	character._play_animation(&"attack")


func update(_delta: float) -> void:
	character._look_at_target()


func _on_animation_finished(anim_name: StringName) -> void:
	if character.target == null:
		finished.emit(&"idle")
		return

	match anim_name:
		&"attack":
			character._play_animation(&"alert")
		&"alert":
			if character._can_see_target():
				fire()
			else:
				finished.emit(&"idle")


func _handle_body_exited(body: Node2D) -> void:
	super(body)
	if character.target == null && character.get_current_animation() != &"attack":
		finished.emit(&"idle")
