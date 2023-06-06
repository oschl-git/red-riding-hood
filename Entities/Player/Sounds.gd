## Handles the sounds player makes.

extends Node

# Node references:
@onready var player: Player = get_parent()
@onready var walk_sounds_player: AudioStreamPlayer = $WalkSounds

# Sounds:
var walking : Array[AudioStream] = [
	preload('res://Audio/Sounds/Walking/1.ogg'),
	preload('res://Audio/Sounds/Walking/2.ogg'),
	preload('res://Audio/Sounds/Walking/3.ogg'),
	preload('res://Audio/Sounds/Walking/4.ogg'),
	preload('res://Audio/Sounds/Walking/5.ogg'),
]
var running : Array[AudioStream] = [
	preload('res://Audio/Sounds/Running/1.ogg'),
	preload('res://Audio/Sounds/Running/2.ogg'),
	preload('res://Audio/Sounds/Running/3.ogg'),
	#preload('res://Audio/Sounds/Running/4.ogg'),
]


# Built-in functions:
func _physics_process(_delta: float) -> void:
	play_walk_sounds()


## Plays the sounds of walking/running.
func play_walk_sounds() -> void:
	if (Global.movement_disabled or 
			Input.get_vector(
				'move_left', 'move_right', 'move_forward', 'move_backward'
			) == Vector2.ZERO): 
		walk_sounds_player.playing = false
		return

	if walk_sounds_player.playing: return

	if not Global.player.running:
		walk_sounds_player.stream = walking[randi() % walking.size()]
	else:
		walk_sounds_player.stream = running[randi() % running.size()]

	walk_sounds_player.playing = true