extends Node3D
class_name UsableItem

# Node references:
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var activated := false


# Built-in functions:
func _ready() -> void:
	if activated:
		visible = true
		change_state_to(true)
	else:
		visible = false
		change_state_to(false)


# Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if state: 
		animation_player.play('activate')
		Global.HUD.item_action_label.display_label(get_item_label())
	else: 
		animation_player.play('deactivate')
		Global.HUD.item_action_label.hide_label()
	
	activated = state


# Reacts to mouse events, should be overriden.
func mouse_input(_event : InputEvent):
	pass


# Returns correct item label, should be overriden.
func get_item_label() -> String:
	return ''
