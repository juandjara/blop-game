extends Node2D

var small_bubble_scene = preload("res://scenes/small_bubble.tscn")
var blop_scene = preload("res://scenes/small_blop.tscn")
var win_music = preload("res://assets/sounds/music/win.wav")

var win_condition = false
var current_blops = 1
@export var blops_needed = 10
@export var max_spawn_distance: float = 320

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var menu: Control = $/root/world/pause_menu
		menu.visible = true
		get_tree().call_deferred("set_pause", true)

func add_blop():
	current_blops += 1
	if current_blops == blops_needed:
		$music_player.stream = win_music
		$music_player.play()		
	if current_blops >= blops_needed:
		win_condition = true


func reset_blops():
	if current_blops <= 1:
		# game over
		get_tree().reload_current_scene()
	current_blops = 1

func _on_timer_timeout() -> void:
	var rect = get_viewport_rect().size
	var half = Vector2(rect.x / 2, rect.y / 2)

	var margin = 25
	var distance = randi_range(margin, max_spawn_distance - margin)
	var angle = randf_range(0, PI * 2)
	var pos = Vector2.from_angle(angle) * distance
	
	var blop: Area2D = blop_scene.instantiate()
	blop.global_position.x = pos.x + half.x
	blop.global_position.y = pos.y + half.y
	
	add_child(blop)


func _on_enemy_timer_timeout() -> void:
	var rect = get_viewport_rect().size
	var half = Vector2(rect.x / 2, rect.y / 2)
	var angle = randf_range(0, PI * 2)
	var extra_angle_choice = randi_range(0, 2)
	
	var anim_key = "straight"
	var inverted = false
	var extra_angle = 0
	if extra_angle_choice != 0:
		anim_key = 'sideways'
	if extra_angle_choice == 1:
		extra_angle += deg_to_rad(30)
	if extra_angle_choice == 2:
		extra_angle -= deg_to_rad(30)
		inverted = true
	
	var pos = Vector2.from_angle(angle) * max_spawn_distance
	
	var bubble: Area2D = small_bubble_scene.instantiate()
	bubble.global_position.x = pos.x + half.x
	bubble.global_position.y = pos.y + half.y
	bubble.anim_key = anim_key
	bubble.inverted = inverted
	bubble.rotate(angle - (PI * 0.5))
	
	var direction = Vector2.from_angle(angle + extra_angle)
	bubble.direction = (direction * -1).normalized()
	
	add_child(bubble)
	
