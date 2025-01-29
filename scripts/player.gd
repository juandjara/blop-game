extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var win_color = Color('#9b64c6')
var is_changing_color = false

func _ready() -> void:
	_animated_sprite.play('idle')
	
func _process(delta: float) -> void:
	if is_changing_color:
		particles.color = particles.color.lerp(win_color, delta)
		
func change_color():
	is_changing_color = true

func grow():
	particles.scale_amount_max += 1
	particles.initial_velocity_max *= -0.8

func reset_growth():
	particles.scale_amount_max = 10
	particles.initial_velocity_max = 8

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED
	velocity = lerp(get_real_velocity(), direction, 0.1)

	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		var body = collision.get_collider()
		if body.is_in_group("outer_bubble"):
			if $/root/world.win_condition:
				body.call_deferred("explode")
				$/root/world/shadow.grow()
	
