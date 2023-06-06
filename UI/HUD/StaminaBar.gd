## Handles the stamina bar UI element.

extends TextureProgressBar

@onready var default_modulate = modulate
const disabled_threshold = 20

# Built-in functions:
func _ready() -> void:
	Global.player.run_stamina_changed.connect(display_value)


## Displays a value on the stamina meter.
func display_value(new_value : int):
	if new_value <= disabled_threshold and value < new_value or new_value <= 0: modulate = (
		Color(0.34117648005486, 0.34117648005486, 0.34117648005486)
	)
	else : modulate = default_modulate

	value = new_value
	visible = value < 100
