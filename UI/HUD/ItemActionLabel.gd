## Handles the action label which is sometimes displayed on the HUD.

extends Label


# Node references: 
@onready var timer : Timer = $Timer
const item_action_label_wait_time : float = 6


# Built-in functions:
func _ready() -> void:
	timer.wait_time = item_action_label_wait_time


## Displays label on the screen.
func display_label(new_text : String, refresh_timer : bool = true):
	text = new_text
	if refresh_timer:
		timer.start()
		visible = true


## Hides the label.
func hide_label() -> void:
	visible = false


## Reacts to timer timeout, hides the label.
func _on_timer_timeout() -> void:
	hide_label()