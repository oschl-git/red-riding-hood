## This script serves as a simple loading screen for the game world.

extends Control


# Built-in functions:
func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	var game_world : PackedScene = load('res://Scenes/game_world.tscn')
	get_tree().change_scene_to_packed(game_world)