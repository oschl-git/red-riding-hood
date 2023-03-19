# Handles the torch on player.

extends UsableItem

signal swing_finished

var swinging := false

# Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if swinging: await swing_finished
	super(state)

# Swings the torch.
func swing() -> void:
	if not activated: return
	if animation_player.is_playing(): return

	swinging = true
	animation_player.play('swing')
	await animation_player.animation_finished
	animation_player.play('activate')
	swing_finished.emit()
	swinging = false


# Reacts to mouse events.
func mouse_input(event : InputEvent):
	if Global.movement_disabled: return
	if animation_player.is_playing(): return

	if event.is_action_pressed('left_mouse_click'): swing()
	elif event.is_action_pressed('right_mouse_click'): change_state_to(false)


func get_item_label() -> String:
	return '[LMB] swing / [RMB] hide'