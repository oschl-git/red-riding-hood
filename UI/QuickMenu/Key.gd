# Handles the key quick menu item.

extends QuickMenuItem


# Built-in functions:
func _ready() -> void:
	disabled_texture = load('res://UI/QuickMenu/Textures/key_unavailable.png')
	enabled_texture = load('res://UI/QuickMenu/Textures/key_available.png')

	unavailable_item_name = 'The Key'
	unavailable_item_description = 'where is it?'
	item_name = 'The Key'
	item_description = 'what is it for?'

	super()


# Executes item action.
func execute_item_action() -> void:
	# TODO: Implement key functionality.
	pass


# Returns the correct item tooltip.
func get_item_tooltip() -> String:
	if not available: return 'step 1: find it. step 2: find what it unlocks.'
	elif not active: return 'find what this key unlocks.'
	else: return 'you\'ve already used this item.'
