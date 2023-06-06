## Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
## Changes the name to be displayed.
func _ready() -> void:
	item_name = 'box of matches'


## Handles being collected.
func collect_item() -> void:
	var amount := randi_range(1,3)
	Global.player.usable_items.torch.matches += amount
	if amount == 1: 
		Global.HUD.item_action_label.display_label('obtained ' + str(amount) + ' match.')
	else: 
		Global.HUD.item_action_label.display_label('obtained ' + str(amount) + ' matches.')