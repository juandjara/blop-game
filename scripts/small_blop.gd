extends Area2D

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play('idle')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		body.grow()
		$/root/world/sfx_blop_player.play()
		$/root/world.add_blop()
		if $/root/world.win_condition:
			body.set_win_color()
	queue_free()
