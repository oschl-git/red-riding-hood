# Parent class for pickable items.

extends Area3D
class_name PickableItem

# Adjustable attributes:
var item_name : String


# Handles being collected, should be overriden.
func collect_item() -> void:
	pass