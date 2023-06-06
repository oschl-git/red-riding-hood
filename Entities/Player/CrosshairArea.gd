## Handles the area that controls crosshair visibility.

extends Area3D


## Built-in functions:
func _physics_process(_delta: float) -> void:
	if has_overlapping_areas() and not Global.quick_menu.visible: 
		Global.HUD.crosshair.set_visibility(true)
	else: 
		Global.HUD.crosshair.set_visibility(false)