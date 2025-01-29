extends Sprite2D

var is_scaling = false
var target_scale = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func grow():
	is_scaling = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_scaling:
		scale.x = move_toward(scale.x, target_scale, delta)
		scale.y = move_toward(scale.y, target_scale, delta)
