## Singleton with global variables.

extends Node


# Game objects:
var player : Player
var wolf : Wolf

# UI elements:
var HUD : HUD
var quick_menu : QuickMenu
var pause_menu : PauseMenu

# States:
var movement_disabled := false

# Settings:
var enable_distortion_effects := true
var enable_timer := false