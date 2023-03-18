# Handles the torch quick menu item.

extends QuickMenuItem


# Built-in functions:
func _ready() -> void:
	disabled_texture = load('res://UI/QuickMenu/Textures/torch_unavailable.png')
	enabled_texture = load('res://UI/QuickMenu/Textures/torch_available.png')

	unavailable_item_name = 'The Torch'
	unavailable_item_description = 'provides protection against those afraid of its light.'
	item_name = 'The Torch'
	item_description = 'provides protection with a limited burntime at the expense of a match.'

	super()


# Executes item action.
func execute_item_action() -> void:
	Global.player.usable_items.toggle_item('torch')
	update_activity()


# Returns the correct item tooltip.
func get_item_tooltip() -> String:
	if not available: return 'you do not have this item.'
	elif not active: return 'click to light. 2 matches remaining.'
	else: return 'click to extinguish.'


# Updates activity.
func update_activity() -> void:
	active = Global.player.usable_items.get_item('torch').activated
