extends CharacterBody3D

@export var walk_speed : float = 2.5
@export var run_speed : float = 4

# References to other nodes:
@onready var camera : Camera3D = $Camera3D
@onready var flashlight : SpotLight3D = $Camera3D/Flashlight

var look_sensitivity : float = ProjectSettings.get_setting('player/look_sensitivity')
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')
var velocity_y : float = 0


func _physics_process(delta: float) -> void:
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

	if is_on_floor():
		velocity_y = 0
	else:
		velocity_y -= gravity * delta

	velocity.y = velocity_y
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(- event.relative.x * look_sensitivity)
		camera.rotate_x(- event.relative.y * look_sensitivity)

	if event.is_action_pressed('toggle_flashlight'):
		flashlight.visible = not flashlight.visible
	
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
