# Handles the flashlight quick menu item.

extends QuickMenuItem


# Built-in functions:
func _ready() -> void:
	disabled_texture = load('res://UI/QuickMenu/Textures/flashlight_unavailable.png')
	enabled_texture = load('res://UI/QuickMenu/Textures/flashlight_available.png')

	unavailable_item_name = 'The Flashlight'
	unavailable_item_description = 'for dark places, when all other lights go out.'
	item_name = 'The Flashlight'
	item_description = 'use to see and to be seen.'

	super()


# Executes item action.
func execute_item_action() -> void:
	Global.player.usable_items.toggle_item('flashlight')
	update_activity()


# Returns the correct item tooltip.
func get_item_tooltip() -> String:
	if not available: return 'you do not have this item.'
	elif not active: return 'click to turn on.'
	else: return 'click to turn off.'


# Updates activity.
func update_activity() -> void:
	active = Global.player.usable_items.get_item('flashlight').activated
