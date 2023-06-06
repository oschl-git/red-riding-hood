## This script handles the chromatic abberation effect when close to the wolf.

extends ColorRect


# Adjustable values:
const max_spread: float = .15
const activation_distance: float = 6
const extreme_spread: float = -2
const extreme_activation_distance: float = 3


# Built-in functions:
func _physics_process(_delta: float) -> void:
	# Stops the effect from happening if it's disabled in the settings:
	if not Global.enable_distortion_effects:
		material.set_shader_parameter('spread', 0)
		return

	var distance := Global.player.global_position.distance_to(Global.wolf.global_position)
	var spread : float

	if distance < extreme_activation_distance:
		var spread_percent: float = 100 - (distance / extreme_activation_distance * 100)
		spread = (extreme_spread / float(100)) * spread_percent if spread_percent > 0 else float(0)
	elif distance < activation_distance:
		var spread_percent : float = 100 - (distance / activation_distance * 100)
		spread = (max_spread / float(100)) * spread_percent if spread_percent > 0 else float(0)

	material.set_shader_parameter('spread', spread)