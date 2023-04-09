# Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
# Changes the name to be displayed.
func _ready() -> void:
	item_name = 'torch'


# Handles being collected.
func collect_item() -> void:
	Global.player.usable_items.torch.once_obtained = true
	Global.HUD.item_action_label.display_label('torch obtained.')
	Global.quick_menu.torch.available = true