# Handles the torch quick menu item.

extends QuickMenuItem


# Built-in functions:
func _ready() -> void:
	disabled_texture = load('res://UI/QuickMenu/Textures/torch_unavailable.png')
	enabled_texture = load('res://UI/QuickMenu/Textures/torch_available.png')

	unavailable_item_name = 'The Torch'
	unavailable_item_description = 'provides protection against those afraid of its light.'
	item_name = 'The Torch'
	item_description = 'use to be protected against those afraid of its light.'

	super()


# Executes item action.
func execute_item_action() -> void:
	pass


# Returns the correct item tooltip.
func get_item_tooltip() -> String:
	if not available: return 'you do not have this item.'
	elif not active: return 'click to light.'
	else: return 'click to extinguish.'
