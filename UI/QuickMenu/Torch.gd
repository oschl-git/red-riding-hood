# Handles the torch quick menu UI item.

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
	if not available: 
		var once_obtained = Global.player.usable_items.torch.once_obtained
		return 'you do not have this item.' if not once_obtained else 'your torch burned out.'
	elif not active: 
		var matches : int = Global.player.usable_items.torch.matches
		if matches <= 0: return 'you have no matches.'
		elif matches == 1: return 'last match.'
		else: return 'your have ' + str(matches) + ' matches remaining.'
	else: return 'click to extinguish.'


# Updates activity.
func update_activity() -> void:
	active = Global.player.usable_items.get_item('torch').activated
