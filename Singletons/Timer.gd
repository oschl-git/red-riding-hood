# This global script manages the timer.

extends Node

var running := false
var time_stamp: int
var stopped_timer_stamp: int


# Sets the timer to count from the moment this function is called.
func set_timer() -> void:
	time_stamp = Time.get_ticks_msec()
	running = true


# Stops the timer.
func stop_timer() -> void:
	stopped_timer_stamp = Time.get_ticks_msec()
	running = false


# Returns a readable string of the time since the timer was set.
func get_elapsed_time_string(include_milliseconds := false) -> String:
	if not time_stamp: return ('00:00' if not include_milliseconds else '00:00:00')
	elif running: return get_string_from_milliseconds(
		Time.get_ticks_msec() - time_stamp, include_milliseconds
	)
	else: return get_string_from_milliseconds(
		stopped_timer_stamp - time_stamp, include_milliseconds
	)


# Converts milliseconds to a readable string.
func get_string_from_milliseconds(ms: int, include_milliseconds := false) -> String:
	var minutes: int = floor(float(ms) / float(60000))
	var seconds: int = floor(float(ms) / float(1000)) - (minutes * 60)
	var milliseconds: int = ms - (minutes * 60000) - (seconds * 1000)

	var output := 'MM:SS:MS' if include_milliseconds else 'MM:SS'
	
	output = output.replace('MM', str(minutes) if minutes > 9 else '0' + str(minutes))
	output = output.replace('SS', str(seconds) if seconds > 9 else '0' + str(seconds))
	output = output.replace('MS', 
		(str(milliseconds) if milliseconds > 9 else '0' + str(milliseconds)).left(2))

	return output;