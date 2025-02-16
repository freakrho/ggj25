extends Node

@export var dialogue_style: DialogicStyle
@export var final_day: int
@export var killable_characters: Array[DialogicCharacter]
@export var pointer_cursor: Resource
@export var interact_cursor: Resource
@export var grab_cursor: Resource
@export var cursor_hotspot: Vector2

func _ready():
    Input.set_custom_mouse_cursor(pointer_cursor, Input.CURSOR_ARROW, cursor_hotspot)
    Input.set_custom_mouse_cursor(interact_cursor, Input.CURSOR_POINTING_HAND, cursor_hotspot)
    Input.set_custom_mouse_cursor(grab_cursor, Input.CURSOR_DRAG, cursor_hotspot)
