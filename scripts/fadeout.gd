extends ColorRect

@onready var animation: AnimationPlayer = $AnimationPlayer

func fadeout():
	animation.play("fadeout")

func _on_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/win.tscn")
