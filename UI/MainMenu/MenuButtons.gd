# A script managing all main menu buttons.

extends Control


# Node references:
@onready var main_menu: Node3D = get_parent().get_parent()
@onready var options_menu: OptionsMenu = get_parent().get_parent().get_node('OptionsMenu')
@onready var credits: Control = get_parent().get_parent().get_node('Credits')


# Button signals:
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file('res://UI/LoadingScreen/loading_screen.tscn')


func _on_options_button_pressed() -> void:
	main_menu.hide_menu()
	options_menu.show_menu()
	
	
func _on_credits_button_pressed() -> void:
	main_menu.hide_menu()
	credits.show_credits()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
