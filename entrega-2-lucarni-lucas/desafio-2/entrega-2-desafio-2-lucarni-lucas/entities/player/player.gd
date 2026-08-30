extends Sprite2D

@onready var cannon:Sprite2D = $Cannon

@export var speed: float = 200.0

var projectile_container:Node

func set_projectile_container(container:Node):
	cannon.projectile_container = container
	self.projectile_container = container



func _physics_process(delta: float) -> void:
	# Movimiento
	var direction := Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta
	
	
	# Cannon
	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
