extends Label

# Node references: 
@onready var timer : Timer = $Timer


@export var item_action_label_wait_time : float = 6


func _ready() -> void:
	timer.wait_time = item_action_label_wait_time


func display_label(new_text : String, refresh_timer : bool = true):
	text = new_text
	if refresh_timer: 
		timer.start()
		visible = true

func hide_label() -> void:
	visible = false


func _on_timer_timeout() -> void:
	hide_label()
