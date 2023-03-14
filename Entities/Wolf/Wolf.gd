extends CharacterBody3D

@export var speed : float = 3

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	$AnimationPlayer.play('Wolf_Run_Cycle_')


func _physics_process(_delta: float) -> void:
	look_at(Global.player.global_position, Vector3.UP)

	update_target_location(Global.player.global_position)

	var current_location : Vector3 = global_transform.origin
	var next_location : Vector3 = nav_agent.get_next_path_position()
	var new_velocity : Vector3 = (next_location - current_location).normalized() * speed

	velocity = new_velocity
	move_and_slide()


func update_target_location(target_location : Vector3) -> void:
	nav_agent.set_target_position(target_location)
