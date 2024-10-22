## Handles the area that detects collisions with the wolf.

extends Area3D

@onready var death_screen : PackedScene = preload('res://UI/DeathScreen/death_screen.tscn')


# Signal responses:
func _on_body_entered(_body: Node3D) -> void:
	if Global.wolf.current_action == Global.wolf.actions.RUNNING_AWAY: return
	get_tree().change_scene_to_packed(death_screen)
