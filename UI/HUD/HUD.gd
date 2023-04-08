# Handles the HUD.

extends Control
class_name HUD


# Node references:
@onready var item_action_label := $ItemActionLabel
@onready var stamina_bar := $StaminaBar
@onready var burntime_bar := $BurntimeBar
@onready var crosshair := $Crosshair


# Built-in functions:
func _enter_tree() -> void:
	Global.HUD = self