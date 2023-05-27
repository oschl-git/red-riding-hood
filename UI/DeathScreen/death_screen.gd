# This script handles the death screen scene.

extends Control

# Node rerefences:
@onready var time_survived = $TimeSurvived

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GlobalTimer.stop_timer()
	time_survived.text = time_survived.text.replace(
		'MM:SS:MS', GlobalTimer.get_elapsed_time_string(true))