# Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
# Changes the name to be displayed.
func _ready() -> void:
	item_name = 'Flashlight'


# Handles being collected.
func collect_item() -> void:
	Global.HUD.item_action_label.display_label('Flashlight obtained.')
	Global.quick_menu.flashlight.available = true
