## This script handles the individual option buttons.

extends Button
class_name OptionsButton


# Node references:
@onready var name_label: Label = $HBoxContainer/Name
@onready var value_label: Label = $HBoxContainer/Value

# Adjustable values:
@onready var default_color = modulate
const hover_color := Color('##ad0015')
const pressed_color := Color('##d4001c')

# Changing variables:
var currently_mouse_inside := false
var currently_pressed := false

# Signals:
signal option_pressed(options_button: OptionButton)


# Built-in functions:
func _ready() -> void:
	var options_menu: OptionsMenu = get_parent().get_parent()
	option_pressed.connect(options_menu.on_option_pressed)


## Sets the value label text to the provided text.
func set_option_value(value: String) -> void:
	value_label.text = value


## Resets the button to the default states.
func reset() -> void:
	currently_pressed = false
	currently_mouse_inside = false
	name_label.modulate = default_color
	value_label.modulate = default_color


# Signal responses:
func _on_pressed() -> void:
	option_pressed.emit(self)


func _on_mouse_entered() -> void:
	currently_mouse_inside = true
	name_label.modulate = hover_color
	value_label.modulate = hover_color


func _on_mouse_exited() -> void:
	currently_mouse_inside = false
	if currently_pressed: return
	name_label.modulate = default_color
	value_label.modulate = default_color


func _on_button_down() -> void:
	currently_pressed = true
	name_label.modulate = pressed_color
	value_label.modulate = pressed_color


func _on_button_up() -> void:
	currently_pressed = false
	if not currently_mouse_inside: 
		_on_mouse_exited()
		return
	name_label.modulate = hover_color
	value_label.modulate = hover_color