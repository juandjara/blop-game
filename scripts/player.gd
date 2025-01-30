extends CharacterBody2D

const SPEED = 200.0

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

# variables for swipe detection
var start_pos: Vector2
var curr_pos: Vector2
var swiping = false

func _ready() -> void:
	_animated_sprite.play('idle')

func set_win_color():
	animation.play("win")

func grow():
	particles.scale_amount_max += 1
	particles.initial_velocity_max *= -0.8

func reset_growth():
	animation.play("damage")
	particles.scale_amount_max = 10
	particles.initial_velocity_max = 8

func get_swipe_direction():
	if Input.is_action_just_pressed("press"):
		if !swiping:
			swiping = true
			start_pos = get_global_mouse_position()
	
	if Input.is_action_pressed("press"):
		if swiping:
			curr_pos = get_global_mouse_position()
	else:
		swiping = false
		
	if swiping:
		return (curr_pos - start_pos).normalized()
	else:
		return Vector2.ZERO

func _physics_process(delta: float) -> void:
	var swipe_direction = get_swipe_direction() * SPEED
	var keyboard_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED
	var direction = keyboard_direction
	if direction.x == 0 and direction.y == 0:
		direction = swipe_direction
	
	velocity = lerp(get_real_velocity(), direction, 0.1)

	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		var body = collision.get_collider()
		if body.is_in_group("outer_bubble"):
			if $/root/world.win_condition:
				body.call_deferred("explode")
				$/root/world/shadow.grow()
