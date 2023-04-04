# Handles the HUD.

extends Control


# Node references:
@onready var item_action_label = $ItemActionLabel
@onready var stamina_bar = $StaminaBar


# Built-in functions:
func _ready() -> void:
	Global.HUD = self