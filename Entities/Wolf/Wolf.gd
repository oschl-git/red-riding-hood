# Handles the wolf (in-game).

extends CharacterBody3D
class_name Wolf


# Node references:
@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

# Adjustable values:
const speed : float = 3
var gravity : float = ProjectSettings.get_setting('physics/3d/default_gravity')

# States:
enum states {
	DEACTIVATED,
	PURSUING_PLAYER,
	FLEEING,
}
var current_state := states.DEACTIVATED

#Actions:
enum actions {
	NOTHING,
	FOLLOW_PLAYER,
	HESITATE,
	RUN_AWAY,
	KILL
}
var current_action := actions.NOTHING

# Built-in functions:
func _ready() -> void:
	Global.wolf = self
	$AnimationPlayer.play('Wolf_Run_Cycle_')


# func _physics_process(_delta: float) -> void:
# 	if velocity != Vector3.ZERO: look_at(global_transform.origin + velocity)
# 	nav_agent.set_target_position(Global.player.global_position)

# 	var current_location : Vector3 = global_transform.origin
# 	var next_location : Vector3 = nav_agent.get_next_path_position()
# 	var new_velocity : Vector3 = (next_location - current_location).normalized() * speed

# 	velocity = new_velocity
# 	move_and_slide()
