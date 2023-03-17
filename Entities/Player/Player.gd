# Handles the player.

extends CharacterBody3D
class_name Player

@export var walk_speed : float = 2.5
@export var run_speed : float = 4

# References to other nodes:
@onready var camera : Camera3D = $Camera3D
@onready var flashlight : Flashlight = $Camera3D/Flashlight
@onready var torch : Torch = $Camera3D/Torch

var look_sensitivity : float = ProjectSettings.get_setting('player/look_sensitivity')
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')
var velocity_y : float = 0


func _ready() -> void:
	Global.player = self


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

	if not Input.is_action_pressed('run') or horizontal_velocity.y >= 0:
		horizontal_velocity = horizontal_velocity * walk_speed
	else:
		horizontal_velocity = horizontal_velocity * run_speed

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

	if event.is_action_pressed('left_mouse_click'):
		torch.swing_torch()
