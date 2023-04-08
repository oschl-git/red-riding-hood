# This class handles the crosshair.

extends TextureRect
class_name Crosshair

# Node references: 
@onready var label = $Label


# Sets crosshair visibility to the provided value.
func set_visibility(value : bool) -> void:
	visible = value


# Shows the provided label or the old one if none provided.
func show_label(value = label.text) -> void:
	label.text = value
	label.visible = true


# Hides the label.
func hide_label() -> void:
	label.visible = false
