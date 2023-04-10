# A script managing all pause menu buttons.

extends Control


# Node references:
@onready var pause_menu : PauseMenu = get_parent()


# Button signals:
func _on_resume_button_pressed() -> void:
	pause_menu.resume()


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file('res://UI/MainMenu/main_menu.tscn')
