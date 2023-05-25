extends Control
class_name OptionsMenu


func _ready() -> void:
	$MenuButtons/SfxVolume.set_option_value(str(GlobalAudio.sfx_volume) + '%')
	$MenuButtons/MusicVolume.set_option_value(str(GlobalAudio.music_volume) + '%')


func on_option_pressed(options_button: OptionsButton) -> void:
	match options_button.get_name():
		'Fullscreen': toggle_fullscreen(options_button)
		'SfxVolume': change_sfx_volume(options_button)
		'MusicVolume': change_music_volume(options_button)
		'Return': go_back()


func toggle_fullscreen(options_button: OptionsButton) -> void:
	BackgroundTasks.toggle_fullscreen()
	if (DisplayServer.window_get_mode() == 
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN): options_button.set_option_value('on')
	else: options_button.set_option_value('off')


func change_sfx_volume(options_button: OptionsButton) -> void:
	GlobalAudio.sfx_volume += 10
	if GlobalAudio.sfx_volume > 100: GlobalAudio.sfx_volume = 0
	AudioServer.set_bus_volume_db(
		GlobalAudio.sfx_bus, 
		linear_to_db(float(GlobalAudio.sfx_volume) / float(100))
	)
	options_button.set_option_value(str(GlobalAudio.sfx_volume) + '%')

func change_music_volume(options_button: OptionsButton) -> void:
	GlobalAudio.music_volume += 10
	if GlobalAudio.music_volume > 100: GlobalAudio.music_volume = 0
	AudioServer.set_bus_volume_db(
		GlobalAudio.music_bus, 
		linear_to_db(float(GlobalAudio.music_volume) / float(100))
	)
	options_button.set_option_value(str(GlobalAudio.music_volume) + '%')


func go_back() -> void:
	get_parent().show_menu()
	visible = false
