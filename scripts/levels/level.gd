class_name Level extends Node2D

@export var map: Map
@export var minigames: Array[Minigame]
@export var start_dialogue: Array[DialogueSettings]
@export var characters: Array[CharacterPair]

func _ready():
    GameManager.current_level = self
    for minigame in minigames:
        minigame.hide()
        minigame.get_parent().remove_child(minigame)
        minigame.connect("Ended", ended_minigame)
    if start_dialogue.size() > 0:
        start_dialogue[min(start_dialogue.size() - 1, SessionManager.current.day)].start_dialogue()

func ended_minigame(minigame: Minigame):
    close_minigame(minigame)

func open_minigame(minigame: Minigame):
    remove_child(map)
    add_child(minigame)
    minigame.show()

func close_minigame(minigame: Minigame):
    set_pause_subtree(map, false)
    if map.get_parent() == null:
        add_child(map)
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
    
