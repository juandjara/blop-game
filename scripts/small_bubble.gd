extends Area2D

var direction: Vector2
var anim_key: String = "straight"
var inverted = false
var is_moving = false
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@export var SPEED = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play(anim_key)
	if anim_key != 'straight':
		var multiplier = -1 if inverted else 1
		_animated_sprite.offset.x = -300 * multiplier
		_animated_sprite.offset.y = -35 * multiplier
		_animated_sprite.flip_h = inverted	


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
	if is_moving and area.is_in_group("blop"):
		_animated_sprite.play("explode")
		$/root/world/sfx_pop_player.play()
		is_moving = false
		area.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if is_moving and body.is_in_group("player"):
		_animated_sprite.play("explode")
		$/root/world/sfx_pop_player.play()
		is_moving = false
		if not $/root/world.win_condition:
			body.reset_growth()
			$/root/world.call_deferred("reset_blops")
