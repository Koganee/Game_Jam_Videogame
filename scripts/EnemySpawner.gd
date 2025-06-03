extends Timer

@export var enemy_scene: PackedScene
@export var spawn_area_radius = 150.0

func _on_timeout():
	var i = 0
	while i != 2:
		var enemy = enemy_scene.instantiate()
		var angle = randf() * TAU
		var spawn_offset = Vector2(cos(angle), sin(angle)) * spawn_area_radius
		enemy.global_position = get_node("/root/Arena/Player").global_position + spawn_offset
		get_tree().current_scene.add_child(enemy)
		i += 1
