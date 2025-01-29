extends StaticBody2D

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play('idle')

func explode():
	_animated_sprite.play('explode')
	_collision_polygon.disabled = true
