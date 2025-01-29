extends Area2D

var direction: Vector2
var anim_key: String = "straight"
var is_moving = false
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const SPEED = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play(anim_key)

func _physics_process(delta: float) -> void:
	if (is_moving && direction):
		global_position += direction * SPEED

func _on_animation_finished() -> void:
	if (_animated_sprite.animation == "explode"):
		queue_free()
	else:
		is_moving = true
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	_animated_sprite.play("explode")
	is_moving = false
	if (area.is_in_group("blop")):
		area.queue_free()
		
		
