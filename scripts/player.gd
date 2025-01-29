extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_animated_sprite.play('idle')


func grow():
	# particles.amount += 5
	particles.scale_amount_max += 1
	particles.initial_velocity_max *= -0.8

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED
	velocity = lerp(get_real_velocity(), direction, 0.1)

	move_and_slide()
	
