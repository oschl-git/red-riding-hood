# Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
# Changes the name to be displayed.
func _ready() -> void:
	item_name = 'Torch'


# Handles being collected.
func collect_item() -> void:
	Global.HUD.item_action_label.display_label('Torch obtained.')
	Global.quick_menu.torch.available = true
