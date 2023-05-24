extends Control
class_name OptionsMenu

func on_option_pressed(options_button: OptionsButton):
	match options_button.get_name():
		'Fullscreen': toggle_fullscreen(options_button)


func toggle_fullscreen(options_button: OptionsButton):
	BackgroundTasks.toggle_fullscreen()
	if (DisplayServer.window_get_mode() == 
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN): options_button.set_option_value('on')
	else: options_button.set_option_value('off')