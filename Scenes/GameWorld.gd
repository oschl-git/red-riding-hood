## The base script for the game world.

extends Node3D


func _ready() -> void:
	GlobalAudio.stop_streaming()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED