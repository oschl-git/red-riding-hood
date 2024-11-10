## Handles animating the wolf.

extends AnimationPlayer


# Node references:
@onready var wolf : Wolf = get_parent()


## Handles wolf animation depending on the current action.
func handle_wolf_animation(action : Wolf.actions) -> void:
	if action == Wolf.actions.HESITATING:
		pause()
		return
	else: play()
	
	match action:
		Wolf.actions.RUNNING_AT_PLAYER: play('Wolf_Run_')
		Wolf.actions.CREEPING_TOWARDS_PLAYER: play('Wolf_creep')
		Wolf.actions.RUNNING_AWAY: play('Wolf_Run_')
		Wolf.actions.FORCE_RUNNING_AT_PLAYER: play('Wolf_Run_')


## Plays an animation.
func play_animation(animation_name: String) -> void:
	play(animation_name)
