## Script for the main menu.

extends Node3D


# Node references:
@onready var animation_player : AnimationPlayer = $AnimationPlayer


# Built-in functions:
func _ready() -> void:
	if not GlobalAudio.music_stream_player.playing:
		GlobalAudio.play_music_from_path('res://Audio/Music/main_menu_theme.ogg')

	animation_player.play('enter_animation')


## Shows the main menu.
func show_menu() -> void:
	$UI.visible = true


## Hides the main menu.
func hide_menu() -> void:
	$UI.visible = false
