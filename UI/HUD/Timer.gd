extends Label


func _ready() -> void:
	GlobalTimer.set_timer()


func _process(_delta: float) -> void:
	visible = Global.enable_timer
	text = GlobalTimer.get_elapsed_time_string(false)