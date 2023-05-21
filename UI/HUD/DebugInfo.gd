extends Label


func _physics_process(_delta: float) -> void:
	text = 'Wolf position: ' + str(Global.wolf.global_position)
