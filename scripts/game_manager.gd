extends Node

@onready var main_menu: PackedScene = load("res://scenes/main_menu.tscn")

var current_level: Level
var player: Player

func load_level(level_scene: PackedScene):
    if current_level != null:
        current_level.queue_free()
    var level = level_scene.instantiate()
    add_child(level)

func input_enabled() -> bool:
    return Dialogic.current_timeline == null

func go_to_main_menu():
    current_level.queue_free()
    get_tree().root.add_child(main_menu.instantiate())
