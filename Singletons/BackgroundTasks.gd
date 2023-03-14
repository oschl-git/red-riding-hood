extends Node


func _ready() -> void:
	initial_setup()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'): handle_mouse_visibility()
	if event.is_action_pressed("fullscreen"): toggle_fullscreen()


# Sets up stuff at the start of the game.
func initial_setup():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


# Handles mouse visibility, called in the _input() function.
func handle_mouse_visibility() -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Toggles fullscreen.
func toggle_fullscreen() -> void:
	if (DisplayServer.window_get_mode() == 
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN):
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_WINDOWED)
	else: DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)