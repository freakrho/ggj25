extends Node

var current_level: Level
var player: Player

func load_level(level_scene: PackedScene):
    if current_level != null:
        current_level.queue_free()
    var level = level_scene.instantiate()
    add_child(level)
