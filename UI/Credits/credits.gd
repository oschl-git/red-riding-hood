extends Control

var viewport_height = ProjectSettings.get_setting('display/window/size/viewport_height')

# Node references:
@onready var credits_container: VBoxContainer = $CreditsContainer

func _process(_delta: float) -> void:
	if not visible: return
	if abs(credits_container.position.y) >= credits_container.size.y + 20: hide_credits()

	credits_container.position.y -= .4


func show_credits() -> void:
	credits_container.position.y = viewport_height + 20
	visible = true


func hide_credits() -> void:
	visible = false
	get_parent().show_menu()


func _input(event: InputEvent) -> void:
	if not visible: return
	if event.is_action_pressed('ui_cancel'): hide_credits()