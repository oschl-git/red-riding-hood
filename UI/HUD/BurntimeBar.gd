## Handles the burn time bar UI element.

extends TextureProgressBar

@onready var default_modulate = modulate
const warning_threshold = 20

# Built-in functions:
func _ready() -> void:
	await Global.player.ready
	Global.player.usable_items.torch.burn_time_changed.connect(display_value)


## Displays a value on the stamina meter.
func display_value(new_value : int):
	if new_value <= warning_threshold: modulate = (
		Color(0.38039216399193, 0.01176470611244, 0)
	)
	else: modulate = default_modulate

	value = new_value
	visible = value < 100
