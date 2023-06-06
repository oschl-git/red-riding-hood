## Constrols the raycast that looks for pickable items.

extends RayCast3D


# Built-in functions:
## Shows collider name on the label if RayCast is colliding.
func _physics_process(_delta: float) -> void:
	if is_colliding():
		Global.HUD.crosshair.show_label(get_collider().item_name)
	else:
		Global.HUD.crosshair.hide_label()


## Handles picking up items.
func _input(event: InputEvent) -> void:
	if is_colliding() and event.is_action_pressed('left_mouse_click'):
		if Global.quick_menu.visible: return

		get_collider().collect_item()
		get_collider().free()