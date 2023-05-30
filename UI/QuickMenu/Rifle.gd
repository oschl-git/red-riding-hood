# Handles the rifle quick menu UI item.

extends QuickMenuItem


# Built-in functions:
func _ready() -> void:
	disabled_texture = load('res://UI/QuickMenu/Textures/questionmark.png')
	enabled_texture = load('res://UI/QuickMenu/Textures/questionmark.png')

	unavailable_item_name = 'Unavailable'
	unavailable_item_description = 'unavailable in this version.'
	# unavailable_item_name = 'The Secret'
	# unavailable_item_description = 'the alluring secret item.'
	item_name = 'The Rifle'
	item_description = 'kill the bastard.'

	super()


# Executes item action.
func execute_item_action() -> void:
	# TODO: implement rifle functionality.
	pass


# Returns the correct item tooltip.
func get_item_tooltip() -> String:
	return ''
	# if not available: return '???'
	# elif not active: return 'used to kill.'
	# else: return 'you\'ve already used this item.'
