extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		close()

	
func close():
	visible = false
	get_tree().call_deferred("set_pause", false)


func _on_restart_pressed() -> void:
	close()
	get_tree().reload_current_scene()


func _on_continue_pressed() -> void:
	close()


func _on_quit_pressed() -> void:
	get_tree().quit()
