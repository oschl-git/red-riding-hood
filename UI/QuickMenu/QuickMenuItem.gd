# A parent class for all quick menu items.

extends Control
class_name QuickMenuItem


# States:
@export var available := false
@export var active := false


# Item type:
enum Types {FLASHLIGHT, TORCH, KEY, RIFLE}
@export var type : Types


# Item textures:
var disabled_texture : CompressedTexture2D
var enabled_texture : CompressedTexture2D


# Item labels:
var unavailable_item_name := 'Unavailable Item Name'
var unavailable_item_description := 'unavailable item description.'
var item_name := 'Item Name'
var item_description := 'item description.'


# Universal textures:
@onready var selection_enable_border := preload(
	'res://UI/QuickMenu/Textures/selection_enable_border.png')
@onready var selection_disable_border := preload(
	'res://UI/QuickMenu/Textures/selection_disable_border.png')
@onready var selection_unavailable_border := preload(
	'res://UI/QuickMenu/Textures/selection_unavailable_border.png')
@onready var availability_available_border := preload(
	'res://UI/QuickMenu/Textures/availability_available_border.png')
@onready var availability_unavailable_border := preload(
	'res://UI/QuickMenu/Textures/availability_unavailable_border.png')


# Node references:
@onready var quick_menu : Control = get_parent()
@onready var texture : TextureRect = $Texture
@onready var availability_border : TextureRect = $AvailabilityBorder
@onready var selection_border : TextureRect = $SelectionBorder

# Changing variables:
var mouse_hovering = false

# Signals:
signal item_hovered(name : String, description : String, tooltip : String)
signal item_clicked()


# Built-in functions:
func _ready() -> void: 
	item_hovered.connect(quick_menu.update_labels)
	item_clicked.connect(quick_menu.item_clicked)
	quick_menu.quick_menu_activated.connect(quick_menu_refresh)
	
	quick_menu_refresh()


func _input(event: InputEvent) -> void:
	if not available: return
	if event.is_action_pressed('left_mouse_click') and mouse_hovering and quick_menu.visible:
		item_clicked.emit()
		execute_item_action()


# Refreshes the menu according to the current state of the game.
func quick_menu_refresh() -> void:
	update_availability_border()
	update_texture()
	hide_selection_border()
	mouse_hovering = false


# Reacts to mouse entering.
func _on_mouse_entered() -> void:
	update_activity()

	if not available: 
		show_selection_border(selection_unavailable_border)
		item_hovered.emit(unavailable_item_name, unavailable_item_description, get_item_tooltip())
		return
	elif not active: show_selection_border(selection_enable_border)
	else: show_selection_border(selection_disable_border)

	item_hovered.emit(item_name, item_description, get_item_tooltip())

	mouse_hovering = true


# Reacts to mouse exiting.
func _on_mouse_exited() -> void:
	hide_selection_border()
	item_hovered.emit('', '', '')

	mouse_hovering = false


# Updates the texture according to the current state.
func update_texture() -> void:
	texture.texture = enabled_texture if available else disabled_texture


# Shows a selection border of the provided border texture.
func show_selection_border(border_texture : Resource) -> void:
	selection_border.texture = border_texture
	selection_border.visible = true


# Hides the selection border.
func hide_selection_border() -> void:
	selection_border.visible = false


# Updates the availability border according to the current state.
func update_availability_border() -> void:
	availability_border.texture = availability_available_border if available \
		else availability_unavailable_border


# Executes item action, should be overriden.
func execute_item_action() -> void:
	pass


# Returns correct item tooltip, should be overriden.
func get_item_tooltip() -> String:
	return 'item tooltip.'


# Updates activity, should be overriden.
func update_activity() -> void:
	pass
