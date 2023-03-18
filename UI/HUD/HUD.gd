extends Control

# Node references:
@onready var item_action_label = $ItemActionLabel

func _ready() -> void:
	Global.HUD = self