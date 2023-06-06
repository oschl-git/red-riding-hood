## Script for the pause menu.

extends Control
class_name PauseMenu

# Node references:
@onready var menu_buttons = $MenuButtons


# Built-in functions:
func _ready() -> void:
	Global.pause_menu = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		if not get_tree().paused: pause()
		else: 
			show_menu()
			menu_buttons.options_menu.hide_menu()
			resume()


## Pauses the game, shows the pause menu.
func pause() -> void:
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true


## Resumes the game, hides the pause menu.
func resume() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


## Shows the menu UI elements.
func show_menu() -> void:
	$Background.visible = true
	$ColorRect.visible = true
	$TitleLabel.visible = true
	$MenuButtons.visible = true


## Hides the menu UI elements.
func hide_menu() -> void:
	$Background.visible = false
	$ColorRect.visible = false
	$TitleLabel.visible = false
	$MenuButtons.visible = false