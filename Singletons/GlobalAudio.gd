# A singleton that plays audio in the background.

extends Node


var audio_stream_player : AudioStreamPlayer
var current_path : String
var current_repeat := false


# Built-in functions:
func _ready() -> void:
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.bus = &"Music"
	add_child(audio_stream_player)

	audio_stream_player.finished.connect(on_stream_finished)


func play_sound_from_path(path : String, repeat : bool = false):
	current_path = path
	current_repeat = repeat
	var stream : AudioStream = load(path)
	audio_stream_player.set_stream(stream)
	audio_stream_player.play()


func stop_streaming():
	audio_stream_player.stop()


func on_stream_finished():
	if current_repeat:
		play_sound_from_path(current_path)