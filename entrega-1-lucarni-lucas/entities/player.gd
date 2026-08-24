extends Sprite2D


 #Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


@export var speed:float = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Basica
	#var direction:int = 0
	#
	#if Input.is_action_pressed("move_left"):
		#direction = -1
	#elif Input.is_action_pressed("move_rigth"):
		#direction = 1
	
	#Mejor (No solo porque usa menos if, sino tambien si uno apreta ambas teclas su valor es 0)
	var direction = int(Input.is_action_pressed("move_rigth")) - int(Input.is_action_pressed("move_left"))
	
	position.x += direction * speed * delta
