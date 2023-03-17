# Handles the flashlight on player.

extends Node3D
class_name Flashlight

# Node references:
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var activated := false

func _ready() -> void:
	if activated:
		visible = true
		change_state_to(true)
	else:
		visible = false
		change_state_to(false)


func toggle_flashlight() -> void:
	change_state_to(not activated)


func change_state_to(state : bool) -> void:
	if state: animation_player.play('activate_flashlight')
	else: animation_player.play('deactivate_flashlight')
	
	activated = state