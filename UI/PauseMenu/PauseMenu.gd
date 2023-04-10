# Script for the pause menu.

extends Control
class_name PauseMenu


# Built-in functions:
func _ready() -> void:
	Global.pause_menu = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		if not get_tree().paused: pause()
		else: resume()


func pause() -> void:
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true


func resume() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED