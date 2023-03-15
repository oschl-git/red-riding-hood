extends Control
class_name QuickMenuItem

enum Items {FLASHLIGHT, TORCH, KEY, RIFLE}

# States:
@export var disabled := true
@export var active := false


# Item type:
@export var type : Items


# Item textures:
@export var disabled_texture : CompressedTexture2D
@export var enabled_texture : CompressedTexture2D


# Item labels:
@export var disabled_item_name : String
@export var disabled_item_description : String
@export var item_name : String
@export var item_description : String


# Universal textures:
@onready var green_border := preload('res://UI/QuickMenu/Textures/green_border.png')
@onready var red_border := preload('res://UI/QuickMenu/Textures/red_border.png')
@onready var available_background := preload('res://UI/QuickMenu/Textures/available_background.png')
@onready var unavailable_background := (
		preload('res://UI/QuickMenu/Textures/unavailable_background.png'))


# Node references:
@onready var quick_menu : Control = get_parent()
@onready var texture : TextureRect = $Texture
@onready var color_border : TextureRect = $ColorBorder
@onready var background : TextureRect = $Background


signal item_hovered(name : String, description : String)
signal item_clicked(type : Items)


func _ready() -> void: 
	item_hovered.connect(quick_menu.update_labels)
	item_clicked.connect(quick_menu.item_clicked)
	quick_menu.quick_menu_activated.connect(quick_menu_refresh)
	quick_menu_refresh()


# Refreshes the menu according to the current state of the game.
func quick_menu_refresh() -> void:
	update_background()
	update_texture()
	hide_border()


# Reacts to mouse entering.
func _on_mouse_entered() -> void:
	if disabled: 
		item_hovered.emit(disabled_item_name, disabled_item_description)
		return
	elif not active: show_border(green_border)
	else: show_border(red_border)

	item_hovered.emit(item_name, item_description)


# Reacts to mouse exiting.
func _on_mouse_exited() -> void:
	hide_border()
	item_hovered.emit('', '')


# Updates the texture according to the current state.
func update_texture() -> void:
	texture.texture = disabled_texture if disabled else enabled_texture


# Shows a border of the provided border texture.
func show_border(border_texture : Resource) -> void:
	color_border.texture = border_texture
	color_border.visible = true


# Hides the border.
func hide_border() -> void:
	color_border.visible = false


# Updates the background according to the current state.
func update_background() -> void:
	if not disabled:
		background.texture = available_background
		background.visible = true

func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed('left_mouse_click'):
		item_clicked.emit(type)
