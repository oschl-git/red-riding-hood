# Singleton with global variables.

extends Node


# Game objects:
var player : Player

# UI elements:
var HUD : HUD
var quick_menu : QuickMenu

# States:
var movement_disabled := false