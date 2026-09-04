extends Sprite2D
class_name Projectile

signal delete_requested(projectile)

@export var speed:float = 50

# Vector normalizado
var direction:Vector2

func _ready() -> void:
	set_physics_process(false)

func set_starting_values(starting_position:Vector2, direction:Vector2):
	global_position = starting_position
	self.direction = direction
	$Timer.start()
	set_physics_process(true)

func _physics_process(delta):
	position += direction*speed*delta


func _on_timer_timeout() -> void:
	emit_signal("delete_requested", self)
