class_name Level extends Node2D

@export var map: Map
@export var minigames: Array[Minigame]

func _ready():
    GameManager.current_level = self
    for minigame in minigames:
        minigame.hide()

func open_minigame(minigame: Minigame):
    minigame.show()
    set_pause_subtree(map, true)

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
    
