# A script managing all main menu buttons.

extends Control


var game_world : PackedScene = preload('res://Scenes/game_world.tscn')


# Button signals:
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_world)


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()