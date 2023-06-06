## Handles the in-game torch.

extends UsableItem


# Adjustable values:
const required_stamina = 25

# Node references:
@onready var player : Player = get_parent().get_parent().get_parent()
@onready var burn_timer : Timer = $BurnTimer

# States:
var swinging := false
var burning_out := false
var once_obtained := false

# Changing variables:
var burn_time_left := 100
var matches := 0

# Signals:
signal swing_finished()
signal burn_time_changed(value : int)


# Built-in functions:
func _ready() -> void:
	burn_timer.start()
	if not activated: burn_timer.paused = true
	
	super()


## Changes state of the item to the provided one.
func change_state_to(state : bool) -> void:
	if state == true:
		if matches <= 0:
			Global.HUD.item_action_label.display_label('requires a match to light.')
			return
		else:
			matches -= 1

	if burning_out: return
	if swinging: await swing_finished
	Global.HUD.burntime_bar.visible = state
	super(state)


## Swings the torch.
func swing() -> void:
	if not activated: return
	if animation_player.is_playing(): return
	if player.run_stamina < required_stamina: return

	swinging = true
	player.decrease_stamina(required_stamina)
	animation_player.play('swing')
	await animation_player.animation_finished
	player.torch_swung.emit()
	animation_player.play('activate')
	swing_finished.emit()
	swinging = false


## Sets burn timer paused to the provided value.
func set_burn_timer_paused(value : bool) -> void:
	burn_timer.paused = value


## Reacts to burn timer timeout.
func _on_burn_timer_timeout() -> void:
	if burn_time_left <= 0:
		burning_out = true 
		burn_timer.paused = true
		animation_player.play('burned_out')
		await animation_player.animation_finished
		burning_out = false
		change_state_to(false)
		Global.quick_menu.torch.available = false
		return

	burn_time_left -= 2
	burn_time_changed.emit(burn_time_left)


## Reacts to mouse events.
func mouse_input(event : InputEvent):
	if Global.movement_disabled: return
	if animation_player.is_playing(): return

	if event.is_action_pressed('left_mouse_click'): swing()
	elif event.is_action_pressed('right_mouse_click'): change_state_to(false)


## Returns action label for the item.
func get_item_label() -> String:
	return '[LMB] swing / [RMB] extinguish'