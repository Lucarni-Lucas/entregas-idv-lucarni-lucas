extends Node2D

@onready var mushroom_body: Sprite2D = $MushroomBody

@export var heal_amount: int = 3
@export var chance_frames: int = 36


func _ready() -> void:
	mushroom_body.frame = randi() % chance_frames


func _on_pick_area_body_entered(body: Node2D) -> void:
	if body.has_method(&"notify_heal"):
		body.notify_heal(heal_amount)
		_remove.call_deferred()


func _remove() -> void:
	get_parent().remove_child(self)
	queue_free()
