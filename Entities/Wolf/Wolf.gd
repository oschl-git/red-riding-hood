# Handles the wolf (in-game) and its AI.

extends CharacterBody3D
class_name Wolf


# Node references:
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var spawn_timer : Timer = $SpawnTimer
@onready var kill_timer : Timer = $KillTimer
@onready var hesitate_timer : Timer = $HesitateTimer

@onready var wolf_points := get_tree().get_nodes_in_group('wolf_points')

# Adjustable values:
const run_speed : float = 5
const creep_speed : float = 1
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')

# States:
enum states {
	DEACTIVATED,
	SPAWNING,
	PURSUING_PLAYER,
	FLEEING,
	KILLING_PLAYER
}
var current_state := states.DEACTIVATED

# Actions:
enum actions {
	NOTHING,
	RUNNING_AT_PLAYER,
	CREEPING_TOWARDS_PLAYER,
	HESITATING,
	RUNNING_AWAY,
	FORCE_RUNNING_AT_PLAYER
}
var current_action := actions.NOTHING

# Changing variables:
var velocity_y: float = 0
var times_swung := 0

var flee_position_found := false
var flee_position: Vector3

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
	match current_state:
		states.DEACTIVATED: deactivate()
		states.SPAWNING: spawn()
		states.PURSUING_PLAYER: pursue_player()
		states.FLEEING: flee()
		states.KILLING_PLAYER: kill_player()
	
	match current_action:
		actions.NOTHING: pass
		actions.RUNNING_AT_PLAYER: run_at_player(delta)
		actions.CREEPING_TOWARDS_PLAYER: creep_towards_player(delta)
		actions.HESITATING: hesitate(delta)
		actions.RUNNING_AWAY: run_away(delta)
		actions.FORCE_RUNNING_AT_PLAYER: force_run_at_player(delta)
	
	animation_player.handle_wolf_animation(current_action)


# State functions:
func deactivate() -> void:
	visible = false
	change_action(actions.NOTHING)
	kill_timer.stop()
	position = Vector3(0, 100, 0)


func spawn() -> void:
	position = choose_wolf_point()
	visible = true
	change_state(states.PURSUING_PLAYER)


func pursue_player() -> void:
	var distance := get_distance_from_player()
	if distance > 5 and current_action == actions.RUNNING_AT_PLAYER or distance > 8:
		change_action(actions.RUNNING_AT_PLAYER)
	elif distance > 3: 
		if current_action == actions.HESITATING: return
		change_action(actions.CREEPING_TOWARDS_PLAYER)
		if kill_timer.is_stopped(): 
			kill_timer.wait_time = randf_range(20, 30)
			kill_timer.start()
	else:
		change_state(states.KILLING_PLAYER)


func flee() -> void:
	kill_timer.stop()
	change_action(actions.RUNNING_AWAY)


func kill_player() -> void:
	$Wolf_Skeleton/Skeleton3D/Wolf_obj_body004.visible = false
	kill_timer.stop()
	change_action(actions.FORCE_RUNNING_AT_PLAYER)


# Action functions:
func run_at_player(delta: float) -> void:
	navigate_toward_player(delta, run_speed)


func creep_towards_player(delta: float) -> void:
	navigate_toward_player(delta, creep_speed)


func hesitate(_delta: float) -> void:
	if hesitate_timer.is_stopped(): hesitate_timer.start()
	look_at(Global.player.global_position)


func run_away(delta: float) -> void:
	if not flee_position_found:
		flee_position = choose_wolf_point()
		flee_position_found = true

	if are_vectors_approximately_equal(global_position, flee_position, 2): 
		flee_position_found = false
		spawn_timer.start()
		change_state(states.DEACTIVATED)
	
	navigate_towards_position(flee_position, delta, run_speed)


func force_run_at_player(delta: float) -> void:
	force_go_toward_player(delta, run_speed)

# Change functions:
func change_state(new_state: states) -> void:
	if new_state == current_state: return
	
	current_state = new_state
	state_changed.emit(current_state)


func change_action(new_action: actions) -> void:
	if new_action == current_action: return
	
	current_action = new_action
	action_changed.emit(current_action)


# Navigates towards the provided position with the provided delta and speed.
func navigate_towards_position(target: Vector3, delta: float, speed: float) -> void:
	look_at_movement_direction()
	
	nav_agent.set_target_position(target)
	var current_location : Vector3 = global_transform.origin
	var next_location : Vector3 = nav_agent.get_next_path_position()
	velocity = (next_location - current_location).normalized() * speed
	
	velocity_y = velocity_y - gravity * delta if not is_on_floor() else float(0)
	velocity.y = velocity_y

	move_and_slide()


# Navigates towards the player with the provided delta and speed.
func navigate_toward_player(delta: float, speed: float) -> void:
	navigate_towards_position(Global.player.global_position, delta, speed)


# Forces going towards player, ignoring the navmesh
func force_go_toward_player(delta: float, speed: float) -> void:
	look_at_movement_direction()
	
	var direction_vector := Global.player.global_position - global_position
	velocity = direction_vector.normalized() * speed
	
	velocity_y = velocity_y - gravity * delta if not is_on_floor() else float(0)
	velocity.y = velocity_y

	move_and_slide()


# Uses the provided percentage as a chance to flee, returns true if fleeing, false if not
func flee_chance(percent : int) -> bool:
	if randi_range(1, 100) <= percent:
		change_state(states.FLEEING)
		return true
	else: 
		return false


# Uses the provided percentage as a chance to flee, returns true if fleeing, false if not
func attack_chance(percent : int) -> bool:
	if randi_range(1, 100) <= percent:
		change_state(states.KILLING_PLAYER)
		return true
	else: 
		return false


# Returns distance between wolf and player.
func get_distance_from_player() -> float:
	return global_position.distance_to(Global.player.global_position)


# Rotates wolf to look in the direction its going.
func look_at_movement_direction() -> void:
	if velocity == Vector3.ZERO: return
	look_at(global_transform.origin + velocity)


# Returns the position of a suitable wolf point.
func choose_wolf_point() -> Vector3:
	var player_position := Global.player.global_position
	var suitable_positions: Array[Vector3] = []
	
	for wolf_point in wolf_points:
		var distance := player_position.distance_to(wolf_point.global_position)
		if distance >= 50: suitable_positions.append(wolf_point.global_position)
	
	suitable_positions.sort()
	return suitable_positions[0] if not suitable_positions.is_empty() else Vector3.ZERO


# Checks if vectors are approximately equal with provided tolerance (proximity)
func are_vectors_approximately_equal(vector1: Vector3, vector2: Vector3, epsilon: float) -> bool:
	var difference = vector1 - vector2
	return abs(difference.x) < epsilon and abs(difference.y) < epsilon and abs(difference.z) < epsilon


# Signal responses:
func on_action_changed(new_action: actions) -> void:
	match new_action:
		actions.RUNNING_AT_PLAYER: 
			flee_chance(10)


func on_player_swung_torch() -> void:
	if not (Global.player.camera.is_position_in_frustum(global_position)
		and get_distance_from_player() < 5): return
	if current_action == actions.HESITATING: return

	current_action = actions.HESITATING
	hesitate_timer.start()

	var result : bool

	if times_swung <= 0: pass
	elif times_swung <= 3: result = flee_chance(20)
	elif times_swung <= 5: result = flee_chance(50)
	elif times_swung <= 8: result = flee_chance(70)
	else: result = flee_chance(100)
	
	if result: 
		times_swung = 0
	else: times_swung += 1


# Timer timeouts:
func _on_spawn_timer_timeout() -> void:
	change_state(states.SPAWNING)


func _on_kill_timer_timeout() -> void:
	change_state(states.KILLING_PLAYER)


func _on_hesitate_timer_timeout() -> void:
	change_action(actions.CREEPING_TOWARDS_PLAYER)
