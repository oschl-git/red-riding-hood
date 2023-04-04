# Handles the quick menu.

extends Control

# Node references:
@onready var item_name_label : Label = $ItemNameLabel
@onready var item_description_label : Label = $ItemDescriptionLabel
@onready var item_tooltip_label : Label = $ItemTooltipLabel


# Signals:
signal quick_menu_activated()


# Built-in functions:
func _ready() -> void:
	update_labels('', '', '')


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('show_quick_menu'): show_quick_menu()
	elif event.is_action_released('show_quick_menu'): hide_quick_menu()


# Shows the quick menu.
func show_quick_menu() -> void:
	quick_menu_activated.emit()
	update_labels('', '', '')
	Global.movement_disabled = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Hides the quick menu.
func hide_quick_menu() -> void:
	Global.movement_disabled = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called with a signal triggered by items, updates item labels.
func update_labels(item_name, item_description, item_tooltip) -> void:
	item_name_label.text = item_name
	item_description_label.text = item_description
	item_tooltip_label.text = item_tooltip


# Called with a signal triggered by items, reacts to successful item clicks.
func item_clicked() -> void:
	hide_quick_menu()