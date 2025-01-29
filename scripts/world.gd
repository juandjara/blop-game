extends Node2D

var small_bubble_scene = preload("res://scenes/small_bubble.tscn")
var blop_scene = preload("res://scenes/small_blop.tscn")

@export var max_spawn_distance: float = 320

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


func _on_enemy_timer_timeout() -> void:
	var rect = get_viewport_rect().size
	var half = Vector2(rect.x / 2, rect.y / 2)
	var angle = randi_range(0, PI * 2)
	var pos = Vector2.from_angle(angle) * max_spawn_distance
	
	var bubble: Area2D = small_bubble_scene.instantiate()
	bubble.global_position.x = pos.x + half.x
	bubble.global_position.y = pos.y + half.y
	bubble.anim_key = "straight"
	bubble.rotate(angle - (PI * 0.5))
	bubble.direction = (pos * -1).normalized()
	
	add_child(bubble)
	
