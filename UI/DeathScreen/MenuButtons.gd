## A script managing all death screen buttons.

extends VBoxContainer


func _on_try_again_button_pressed() -> void:
	get_tree().change_scene_to_file('res://UI/LoadingScreen/loading_screen.tscn')
	

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file('res://UI/MainMenu/main_menu.tscn')