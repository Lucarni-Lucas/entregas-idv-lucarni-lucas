extends Node2D

@export var turret_scene: PackedScene
@export var turret_amount: int = 3
@export var spawn_area: Rect2 = Rect2(60, 60, 680, 280)
@export var min_distance_between_turrets: float = 120.0

const MAX_ATTEMPTS: int = 30

var used_positions: Array[Vector2] = []


func spawn_turrets(player: Node2D, projectile_container: Node) -> void:
	used_positions.clear()
	for i in turret_amount:
		var turret: Node2D = turret_scene.instantiate()
		add_child(turret)
		turret.global_position = get_valid_position()
		turret.set_values(player, projectile_container)


func get_valid_position() -> Vector2:
	var candidate: Vector2 = get_random_point()
	var attempts: int = 0
	
	while attempts < MAX_ATTEMPTS and not is_far_enough(candidate):
		candidate = get_random_point()
		attempts += 1
	
	used_positions.append(candidate)
	return candidate


func get_random_point() -> Vector2:
	return Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y)
	)


func is_far_enough(candidate: Vector2) -> bool:
	for used in used_positions:
		if candidate.distance_to(used) < min_distance_between_turrets:
			return false
	return true
