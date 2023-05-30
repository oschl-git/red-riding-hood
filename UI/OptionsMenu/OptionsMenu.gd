extends Control
class_name OptionsMenu


# Node references:
@onready var fullscreen_button = $MenuButtons/Fullscreen
@onready var sfx_volume_button = $MenuButtons/SfxVolume
@onready var music_volume_button = $MenuButtons/MusicVolume
@onready var timer_button = $MenuButtons/Timer
@onready var distortion_effects_button = $MenuButtons/DistortionEffects


func _ready() -> void:
	fullscreen_button.set_option_value(
		'on' if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN 
		else 'off'
	)
	sfx_volume_button.set_option_value(
		str(round(db_to_linear(AudioServer.get_bus_volume_db(GlobalAudio.sfx_bus)) * 100)) + '%')
	music_volume_button.set_option_value(
		str(round(db_to_linear(AudioServer.get_bus_volume_db(GlobalAudio.music_bus)) * 100)) + '%')
	timer_button.set_option_value('on' if Global.enable_timer else 'off')
	distortion_effects_button.set_option_value('on' if Global.enable_distortion_effects else 'off')


func show_menu() -> void:
	for button in get_tree().get_nodes_in_group('option_buttons'):
		button.reset()
	visible = true


func hide_menu() -> void:
	visible = false


func on_option_pressed(options_button: OptionsButton) -> void:
	match options_button.get_name():
		'Fullscreen': toggle_fullscreen(options_button)
		'SfxVolume': change_sfx_volume(options_button)
		'MusicVolume': change_music_volume(options_button)
		'Timer': toggle_timer(options_button)
		'DistortionEffects': toggle_distortion_effects(options_button)
		'Return': go_back()


func toggle_fullscreen(options_button: OptionsButton) -> void:
	BackgroundTasks.toggle_fullscreen()
	if (DisplayServer.window_get_mode() == 
		DisplayServer.WINDOW_MODE_FULLSCREEN): options_button.set_option_value('on')
	else: options_button.set_option_value('off')


func change_sfx_volume(options_button: OptionsButton) -> void:
	var new_volume: int = round(db_to_linear(
		AudioServer.get_bus_volume_db(GlobalAudio.sfx_bus)) * 100)
	new_volume = new_volume + 10 if new_volume < 100 else 0
	AudioServer.set_bus_volume_db(
		GlobalAudio.sfx_bus, 
		linear_to_db(float(new_volume) / float(100))
	)
	options_button.set_option_value(str(new_volume) + '%')


func change_music_volume(options_button: OptionsButton) -> void:
	var new_volume: int = round(db_to_linear(
		AudioServer.get_bus_volume_db(GlobalAudio.music_bus)) * 100)
	new_volume = new_volume + 10 if new_volume < 100 else 0
	AudioServer.set_bus_volume_db(
		GlobalAudio.music_bus, 
		linear_to_db(float(new_volume) / float(100))
	)
	options_button.set_option_value(str(new_volume) + '%')


func toggle_timer(options_button: OptionsButton) -> void:
	Global.enable_timer = not Global.enable_timer
	options_button.set_option_value('on' if Global.enable_timer else 'off')


func toggle_distortion_effects(options_button: OptionsButton) -> void:
	Global.enable_distortion_effects = not Global.enable_distortion_effects
	options_button.set_option_value('on' if Global.enable_distortion_effects else 'off')


func go_back() -> void:
	hide_menu()
	get_parent().show_menu()