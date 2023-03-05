extends CharacterBody3D

@export var speed := 5
@export var jump_velocity := 4.5

# References to other nodes:
@onready var camera : Camera3D = $Camera3D

var look_sensitivity : float = ProjectSettings.get_setting('player/look_sensitivity')
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')
var velocity_y : float = 0


func _physics_process(delta: float) -> void:
	var horizontal_velocity := (
		Input.get_vector(
			'move_left', 'move_right', 'move_forward', 'move_backward'
		).normalized() * speed
	)

	velocity = (
		horizontal_velocity.x * global_transform.basis.x + 
		horizontal_velocity.y * global_transform.basis.z
	)

	if is_on_floor():
		velocity_y = 0
		if Input.is_action_just_pressed('jump'): velocity_y = jump_velocity
	else:
		velocity_y -= gravity * delta

	velocity.y = velocity_y
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(- event.relative.x * look_sensitivity)
		camera.rotate_x(- event.relative.y * look_sensitivity)
	
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)