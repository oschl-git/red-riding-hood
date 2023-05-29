extends Node3D

# Node references:
@onready var wolf: Wolf = get_parent()
@onready var growls_player: AudioStreamPlayer3D = $Growls
@onready var growls_timer: Timer = $Growls/Timer

# Sounds:
var growls : Array[AudioStream] = [
	preload('res://Audio/Sounds/Wolf/Growls/1.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/2.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/3.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/4.ogg'),
]
var kill: AudioStream = preload('res://Audio/Sounds/Wolf/kill.ogg')


func _physics_process(_delta: float) -> void:
	play_growl_sounds()


func play_growl_sounds():
	if wolf.current_state == wolf.states.KILLING_PLAYER:
		if growls_player.playing and growls_player.stream == kill: return
		growls_player.stream = kill
		growls_player.play()

	if wolf.get_distance_from_player() > 15 or not growls_timer.is_stopped(): return
	growls_timer.wait_time = randi_range(2, 4)
	growls_timer.start()


func _on_timer_timeout() -> void:
	growls_player.stream = growls[randi() % growls.size()]
	growls_player.play()