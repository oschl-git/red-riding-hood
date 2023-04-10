# Handles the wolf (in-game).

extends CharacterBody3D
class_name Wolf


# Node references:
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Adjustable values:
const run_speed : float = 5
const creep_speed : float = .5
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')

# States:
enum states {
	DEACTIVATED,
	PURSUING_PLAYER,
	FLEEING,
	KILLING_PLAYER
}
var current_state := states.PURSUING_PLAYER

# Actions:
enum actions {
	NOTHING,
	RUNNING_AT_PLAYER,
	CREEPING_TOWARDS_PLAYER,
	RUNNING_AWAY,
}
var current_action := actions.NOTHING

# Changing variables:
var velocity_y : float = 0

# Signals:
signal state_changed(new_state: states)
signal action_changed(new_action: actions)

# Built-in functions:
func _ready() -> void:
	Global.wolf = self
	$AnimationPlayer.play('Wolf_Run_Cycle_')
	action_changed.connect(on_action_changed)
	Global.player.torch_swung.connect(on_player_swung_torch)


func _physics_process(delta: float) -> void:
	print('state: ' + str(current_state) + ', action: ' + str(current_action))

	match current_state:
		states.DEACTIVATED: deactivate()
		states.PURSUING_PLAYER: pursue_player()
		states.FLEEING: flee()
		states.KILLING_PLAYER: kill_player()
	
	match current_action:
		actions.NOTHING: pass
		actions.RUNNING_AT_PLAYER: run_at_player(delta)
		actions.CREEPING_TOWARDS_PLAYER: creep_towards_player(delta)
		actions.RUNNING_AWAY: run_away(delta)
	
	animation_player.handle_wolf_animation(current_action)



# State functions:
func deactivate() -> void:
	pass


func pursue_player() -> void:
	var distance := get_distance_from_player()
	if distance > 8: change_action(actions.RUNNING_AT_PLAYER)
	elif distance > 4: change_action(actions.CREEPING_TOWARDS_PLAYER)
	else: change_state(states.KILLING_PLAYER)


func flee() -> void:
	change_action(actions.RUNNING_AWAY)


func kill_player() -> void:
	pass



# Action functions:
func run_at_player(delta: float) -> void:
	go_toward_player(delta, run_speed)


func creep_towards_player(delta: float) -> void:
	go_toward_player(delta, creep_speed)


func run_away(delta: float) -> void:
	go_towards_position(Vector3(-200, 0, -200), delta, run_speed)


###
func on_action_changed(new_action: actions) -> void:
	match new_action:
		actions.RUNNING_AT_PLAYER: flee_attack_or_ignore(5, 5)


func on_player_swung_torch() -> void:
	flee_attack_or_ignore(5, 100)


func go_toward_player(delta: float, speed: float) -> void:
	go_towards_position(Global.player.global_position, delta, speed)


func go_towards_position(target: Vector3, delta: float, speed: float) -> void:
	if velocity != Vector3.ZERO: look_at(global_transform.origin + velocity)
	
	nav_agent.set_target_position(target)
	var current_location : Vector3 = global_transform.origin
	var next_location : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_location - current_location).normalized() * speed
	
	velocity_y = velocity_y - gravity * delta if not is_on_floor() else float(0)
	velocity.y = velocity_y

	move_and_slide()


func flee_attack_or_ignore(flee_chance: int, attack_chance: int) -> void:
	if randi_range(1, flee_chance) == 1: change_state(states.FLEEING)
	elif randi_range(1, attack_chance) == 1: change_state(states.KILLING_PLAYER)


func get_distance_from_player() -> float:
	return global_position.distance_to(Global.player.global_position)


func change_state(new_state: states) -> void:
	if new_state == current_state: return
	
	current_state = new_state
	state_changed.emit(current_state)


func change_action(new_action: actions) -> void:
	if new_action == current_action: return
	
	current_action = new_action
	action_changed.emit(current_action)
