## This script handles the opening splash screen.

extends Control


# Node references:
@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Main menu scene:
@onready var main_menu : PackedScene = preload('res://UI/MainMenu/main_menu.tscn')


func _ready() -> void:
	GlobalAudio.play_music_from_path('res://Audio/Music/main_menu_theme.ogg')

	await get_tree().create_timer(1).timeout
	animation_player.play('opening_splash')
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(main_menu)
