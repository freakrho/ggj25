extends Level

@export var cup_dialogues: Array[DialogueSettings]
@export var cup_owners: Array[DialogicCharacter]
@export var character_nodes: Array[Node]


func _ready() -> void:
    super()
    for i in range(cup_owners.size()):
        if cup_owners[i] in SessionManager.current.killed:
            var character_node = character_nodes[i]
            character_node.get_parent().remove_child(character_node)

func _on_coffee_minigame_ended(minigame: Minigame) -> void:
    minigame.close_minigame()
    end_sequence()

func end_sequence():
    Dialogic.timeline_ended.connect(go_to_laundry)
    for i in range(cup_owners.size()):
        if cup_owners[i] == SessionManager.current.selected_for_killing:
            cup_dialogues[i].start_dialogue()

func go_to_laundry():
    Dialogic.timeline_ended.disconnect(go_to_laundry)
    GameManager.load_level.call_deferred(LevelList.laundry)
