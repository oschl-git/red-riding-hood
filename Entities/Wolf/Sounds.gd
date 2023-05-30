extends Node3D

# Node references:
@onready var wolf: Wolf = get_parent()

@onready var growls_player: AudioStreamPlayer3D = $Growls
@onready var growls_timer: Timer = $Growls/Timer

@onready var footsteps_player: AudioStreamPlayer3D = $Footsteps

# Sounds:
var growls : Array[AudioStream] = [
	preload('res://Audio/Sounds/Wolf/Growls/1.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/2.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/3.ogg'),
	#preload('res://Audio/Sounds/Wolf/Growls/4.ogg'),
]
var kill: AudioStream = preload('res://Audio/Sounds/Wolf/kill.ogg')

var sneak: AudioStream = preload('res://Audio/Sounds/Wolf/sneak.ogg')
var run: AudioStream = preload('res://Audio/Sounds/Wolf/run.ogg')


func _physics_process(_delta: float) -> void:
	play_growl_sounds()
	play_footstep_sounds()


func play_growl_sounds():
	if wolf.current_state == wolf.states.KILLING_PLAYER:
		if growls_player.playing and growls_player.stream == kill: return
		growls_player.stream = kill
		growls_player.play()
	
	elif wolf.current_state == wolf.states.PURSUING_PLAYER:
		if wolf.get_distance_from_player() > 15 or not growls_timer.is_stopped(): return
		growls_timer.wait_time = randi_range(2, 4)
		growls_timer.start()


func _on_timer_timeout() -> void:
	if wolf.current_state != wolf.states.PURSUING_PLAYER: return
	growls_player.stream = growls[randi() % growls.size()]
	growls_player.play()


func play_footstep_sounds():
	if (wolf.current_action == wolf.actions.RUNNING_AT_PLAYER or 
		wolf.current_action == wolf.actions.FORCE_RUNNING_AT_PLAYER or 
		wolf.current_action == wolf.actions.RUNNING_AWAY):

		if footsteps_player.playing and footsteps_player.stream == run: return	
		footsteps_player.stream = run
		footsteps_player.play()

	else:
		if footsteps_player.playing and footsteps_player.stream == sneak: return
		footsteps_player.stream = sneak
		footsteps_player.play()