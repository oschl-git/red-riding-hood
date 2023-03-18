# Handles the flashlight on player.

extends UsableItem

# Node references:
@onready var spotlight3d : SpotLight3D = $SpotLight3D

var lit : bool:
	get: return spotlight3d.visible


# Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if not activated: spotlight3d.visible = true

	super(state)


func toggle_flashlight() -> void:
	spotlight3d.visible = not spotlight3d.visible
	
	if spotlight3d.visible:
		Global.HUD.item_action_label.display_label('[LMB] turn off / [RMB] hide', false)
	else:
		Global.HUD.item_action_label.display_label('[LMB] turn on / [RMB] hide', false)

# Reacts to mouse events.
func mouse_input(event : InputEvent):
	if Global.movement_disabled: return
	if animation_player.is_playing(): return

	if event.is_action_pressed('left_mouse_click'): toggle_flashlight()
	elif event.is_action_pressed('right_mouse_click'): change_state_to(false)


func get_item_label() -> String:
	return '[LMB] turn off / [RMB] hide'