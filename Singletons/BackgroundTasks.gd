extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'): handle_mouse_visibility()
	if event.is_action_pressed("fullscreen"): toggle_fullscreen()

# Handles mouse visibility, called in the _input() function
func handle_mouse_visibility() -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func toggle_fullscreen() -> void:
	if (DisplayServer.window_get_mode() == 
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_WINDOWED)
	else: DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)