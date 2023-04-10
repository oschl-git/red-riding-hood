# Handles the player.

extends CharacterBody3D
class_name Player


# Adjustable attributes:
const walk_speed : float = 2
const run_speed : float = 4
const stamina_loss_rate : float = .05
const stamina_recovery_rate : float = .15
var look_sensitivity : float = ProjectSettings.get_setting('player/look_sensitivity')
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')

# Node references:
@onready var camera : Camera3D = $Camera3D
@onready var usable_items : UsableItems = $Camera3D/UsableItems
@onready var run_stamina_timer : Timer = $RunStaminaTimer

# Changing variables:
var velocity_y : float = 0
var can_run := true
var running := false
var run_stamina : int = 100

# Signals:
signal run_stamina_changed(value : int)


# Built-in functions:
func _enter_tree() -> void:
	Global.player = self


func _ready() -> void:
	$MeshInstance3D.visible = false


func _physics_process(delta: float) -> void:
	player_movement(delta)


func _input(event: InputEvent) -> void:
	camera_movement(event)


# Handles physical player movement.
func player_movement(delta : float):
	if Global.movement_disabled: return

	var horizontal_velocity : Vector2 = (
		Input.get_vector(
			'move_left', 'move_right', 'move_forward', 'move_backward'
		).normalized()
	)

	if not Input.is_action_pressed('run') or horizontal_velocity.y >= 0 or not can_run:
		horizontal_velocity = horizontal_velocity * walk_speed
		running = false
	else:
		if run_stamina_timer.is_stopped(): run_stamina_timer.start()
		horizontal_velocity = horizontal_velocity * run_speed
		running = true

	velocity = (
		horizontal_velocity.x * global_transform.basis.x + 
		horizontal_velocity.y * global_transform.basis.z
	)

	velocity_y = velocity_y - gravity * delta if not is_on_floor() else float(0)
	velocity.y = velocity_y

	move_and_slide()


# Handles camera movement.
func camera_movement(event : InputEvent):
	if Global.movement_disabled: return

	if event is InputEventMouseMotion: 
		rotate_y(- event.relative.x * look_sensitivity)
		camera.rotate_x(- event.relative.y * look_sensitivity)
	
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


# Triggered when the stamina timer runs out.
func _on_run_stamina_timer_timeout() -> void:
	can_run = run_stamina >= 20 or run_stamina >= 1 and running

	if running: 
		if Global.movement_disabled: return
		run_stamina_timer.wait_time = stamina_loss_rate
		run_stamina -= 1
	elif not Input.is_action_pressed('run') or run_stamina >= 2: 
		run_stamina_timer.wait_time = stamina_recovery_rate
		run_stamina += 1
	
	run_stamina_changed.emit(run_stamina)
	
	if not running and run_stamina >= 100:
		run_stamina = 100
		run_stamina_timer.stop()


# Decreases stamina by the provided amount.
func decrease_stamina(amount : int) -> void:
	if amount > run_stamina: run_stamina = 0
	else: run_stamina -= amount
	run_stamina_changed.emit(run_stamina)
	if run_stamina_timer.is_stopped(): run_stamina_timer.start()