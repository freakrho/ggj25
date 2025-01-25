class_name Level extends Node2D

@export var map: Map
@export var minigames: Array[Minigame]

func _ready():
    GameManager.current_level = self
    for minigame in minigames:
        minigame.hide()
        minigame.get_parent().remove_child(minigame)
        minigame.connect("Ended", ended_minigame)

func ended_minigame(minigame: Minigame):
    close_minigame(minigame)

func open_minigame(minigame: Minigame):
    set_pause_subtree(map, true)
    map.hide_map()
    add_child(minigame)
    minigame.show()

func close_minigame(minigame: Minigame):
    set_pause_subtree(map, false)
    map.show_map()
    remove_child(minigame)

func set_pause_subtree(root: Node, pause: bool) -> void:
    var process_setters = [
        "set_process",
        "set_physics_process",
        "set_process_input",
        "set_process_unhandled_input",
        "set_process_unhandled_key_input",
        "set_process_shortcut_input",
    ]

    for setter in process_setters:
        root.propagate_call(setter, [!pause])
    
