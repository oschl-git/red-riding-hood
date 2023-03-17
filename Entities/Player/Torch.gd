# Handles the torch on player.

extends Node3D
class_name Torch

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


func toggle_torch() -> void:
	change_state_to(not activated)


func swing_torch() -> void:
	animation_player.play('swing_torch')
	await animation_player.animation_finished
	animation_player.play('activate_torch')


func change_state_to(state : bool) -> void:
	if state: animation_player.play('activate_torch')
	else: animation_player.play('deactivate_torch')
	
	activated = state