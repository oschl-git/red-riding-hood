## A singleton that plays audio in the background.

extends Node


var music_stream_player : AudioStreamPlayer
var current_path : String
var current_repeat := false

@onready var sfx_bus := AudioServer.get_bus_index('SFX')
@onready var music_bus := AudioServer.get_bus_index('Music')


# Built-in functions:
func _ready() -> void:
	music_stream_player = AudioStreamPlayer.new()
	music_stream_player.bus = &"Music"
	add_child(music_stream_player)

	music_stream_player.finished.connect(on_stream_finished)


## Plays a music file from the provided path.
## Optionally, provide a boolean value if sound should repeat.
func play_music_from_path(path : String, repeat : bool = false):
	current_path = path
	current_repeat = repeat
	var stream : AudioStream = load(path)
	music_stream_player.set_stream(stream)
	music_stream_player.play()


## Stops any sounds from playing.
func stop_streaming():
	music_stream_player.stop()


func on_stream_finished():
	if current_repeat:
		play_music_from_path(current_path)