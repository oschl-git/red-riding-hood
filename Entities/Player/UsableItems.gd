## Handles usable items on the player.

extends Node3D
class_name UsableItems

# Node references:
@onready var flashlight := $Flashlight
@onready var torch := $Torch

var items : Dictionary


# Built-in functions:
func _ready() -> void:
	items = {
		'flashlight': flashlight,
		'torch': torch,
	}


func _input(event: InputEvent) -> void:
	if Global.HUD.crosshair.label.visible: return
	if event.is_action_pressed('left_mouse_click') or event.is_action_pressed('right_mouse_click'):
		var item_values := items.values()
		for i in item_values:
			if i.activated: i.mouse_input(event)


## Toggles an item (provided in string form)
func toggle_item(item : String) -> void:
	var item_values := items.values()
	
	for i in item_values:
		if i.activated:
			await i.change_state_to(false)
			if i == items[item]: return
			
			await i.animation_player.animation_finished
			break
	
	items[item].change_state_to(true)


## Returns usable item.
func get_item(item : String) -> UsableItem:
	return items[item]