# Handles the in-game flashlight.

extends UsableItem


# States:
var lit : bool:
	get: return spotlight3d.visible

# Node references:
@onready var spotlight3d : SpotLight3D = $SpotLight3D


# Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if not activated: spotlight3d.visible = true
	super(state)


# Toggles the flashlight.
func toggle_flashlight() -> void:
	spotlight3d.visible = not spotlight3d.visible


# Reacts to mouse events.
func mouse_input(event : InputEvent):
	if Global.movement_disabled: return
	if animation_player.is_playing(): return

	if event.is_action_pressed('left_mouse_click'): toggle_flashlight()
	elif event.is_action_pressed('right_mouse_click'): change_state_to(false)


# Returns action label for the item.
func get_item_label() -> String:
	return '[LMB] toggle / [RMB] hide'