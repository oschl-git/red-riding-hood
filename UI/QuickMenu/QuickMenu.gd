extends Control

# Node references:
@onready var item_name_label : Label = $ItemNameLabel
@onready var item_description_label : Label = $ItemDescriptionLabel

signal quick_menu_activated

func _ready() -> void:
	update_labels('', '')

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('show_quick_menu'): show_quick_menu()
	elif event.is_action_released('show_quick_menu'): hide_quick_menu()

func show_quick_menu() -> void:
	quick_menu_activated.emit()
	update_labels('', '')
	Global.movement_disabled = true
	visible = true
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hide_quick_menu() -> void:
	Global.movement_disabled = false
	visible = false
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update_labels(item_name, item_description) -> void:
	item_name_label.text = item_name
	item_description_label.text = item_description

func item_clicked(type : QuickMenuItem.Items) -> void:
	if type == QuickMenuItem.Items.FLASHLIGHT:
		Global.player.toggle_flashlight()
		$Flashlight.active = not $Flashlight.active
		hide_quick_menu()
