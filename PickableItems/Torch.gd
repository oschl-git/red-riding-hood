## Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
## Changes the name to be displayed.
func _ready() -> void:
	item_name = 'torch'


## Handles being collected.
func collect_item() -> void:
	if not Global.player.usable_items.torch.once_obtained:
		Global.HUD.item_action_label.display_label('torch obtained.')
		Global.player.usable_items.torch.once_obtained = true
	else: Global.HUD.item_action_label.display_label('torch replenished.')

	Global.player.usable_items.torch.burn_time_left = 100
	Global.quick_menu.torch.available = true