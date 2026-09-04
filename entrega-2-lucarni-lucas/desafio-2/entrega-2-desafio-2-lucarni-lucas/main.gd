extends Node

func _ready() -> void:
	$Player.set_projectile_container(self)
	$TurretSpawner.spawn_turrets($Player, self)
	
