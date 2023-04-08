# Extends the flashlight pickable item.

extends PickableItem


# Built-in functions:
# Changes the name to be displayed.
func _ready() -> void:
	item_name = 'Box of matches'


# Handles being collected.
func collect_item() -> void:
	var amount := randi_range(2,3)
	Global.player.usable_items.torch.matches += amount
	Global.HUD.item_action_label.display_label('Obtained ' + str(amount) + ' matches.')