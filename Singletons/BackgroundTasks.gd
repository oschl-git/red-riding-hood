# Singleton running in the background, handling various things.

extends Node


# Built-in functions:
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	initial_setup()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"): toggle_fullscreen()
	elif event.is_action_pressed('debug_restart'): get_tree().reload_current_scene()


# Sets up stuff at the start of the game.
func initial_setup():
	# DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	pass


# Toggles fullscreen.
func toggle_fullscreen() -> void:
	if (DisplayServer.window_get_mode() == 
			DisplayServer.WINDOW_MODE_FULLSCREEN):
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_WINDOWED)
	else: DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_FULLSCREEN)