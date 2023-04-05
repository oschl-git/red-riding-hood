# Handles the in-game torch.

extends UsableItem


# Adjustable values:
const required_stamina = 25

# Node references:
@onready var player : Player = get_parent().get_parent().get_parent()

# States:
var swinging := false

# Signals:
signal swing_finished()


# Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if swinging: await swing_finished
	super(state)


# Swings the torch.
func swing() -> void:
	if not activated: return
	if animation_player.is_playing(): return
	if player.run_stamina < required_stamina: return

	swinging = true
	player.decrease_stamina(required_stamina)
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


# Returns action label for the item.
func get_item_label() -> String:
	return '[LMB] swing / [RMB] hide'