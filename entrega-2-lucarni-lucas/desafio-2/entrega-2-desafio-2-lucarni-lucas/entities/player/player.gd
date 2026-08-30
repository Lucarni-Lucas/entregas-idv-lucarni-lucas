extends Sprite2D

@onready var cannon:Sprite2D = $Cannon

const ACCELERATION: float = 20.0
const H_SPEED_LIMIT: float = 400.0
const FRICTION_WEIGHT: float = 0.2

var projectile_container:Node

var velocity: Vector2 = Vector2.ZERO

func set_projectile_container(container:Node):
	cannon.projectile_container = container
	self.projectile_container = container


func _physics_process(delta: float) -> void:
	# Movimiento
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if h_movement_direction != 0:
		velocity.x = clampf(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerpf(velocity.x, 0, FRICTION_WEIGHT) if absf(velocity.x) > 1 else 0
	position += velocity * delta
	
	# Cannon
	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
