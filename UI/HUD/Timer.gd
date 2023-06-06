## This class handles the timer on the HUD.

extends Label

# Built-in functions:
func _ready() -> void:
	GlobalTimer.set_timer()


func _process(_delta: float) -> void:
	visible = Global.enable_timer
	text = GlobalTimer.get_elapsed_time_string(false)