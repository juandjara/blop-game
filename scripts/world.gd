extends Node2D

var blop_scene = preload("res://scenes/small_blop.tscn")
@export var max_spawn_distance: float = 225

func _on_timer_timeout() -> void:
	var rect = get_viewport_rect().size
	var half = Vector2(rect.x / 2, rect.y / 2)

	var margin = 25
	var distance = randi_range(margin, max_spawn_distance - margin)
	var angle = randi_range(0, PI * 2)
	var pos = Vector2.from_angle(angle) * distance
	
	var blop: Area2D = blop_scene.instantiate()
	blop.global_position.x = pos.x + half.x
	blop.global_position.y = pos.y + half.y
	
	add_child(blop)
