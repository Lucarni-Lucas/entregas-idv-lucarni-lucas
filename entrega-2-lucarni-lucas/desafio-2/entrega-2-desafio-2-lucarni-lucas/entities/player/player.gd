extends Sprite2D

@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta
