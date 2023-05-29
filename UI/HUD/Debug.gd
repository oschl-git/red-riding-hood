extends Label

func _physics_process(_delta: float) -> void:
	text = str(Global.wolf.global_position) + '\n' + str(Global.player.global_position)