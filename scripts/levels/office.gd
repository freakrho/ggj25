extends Level

@export var cup_1_dialogue: DialogueSettings
@export var cup_2_dialogue: DialogueSettings
@export var cup_3_dialogue: DialogueSettings


func _on_coffee_minigame_ended(minigame: Minigame) -> void:
    end_sequence()

func end_sequence():
    Dialogic.timeline_ended.connect(go_to_laundry)
    if SessionManager.current.selected_cup == "Cup1":
        cup_1_dialogue.start_dialogue()
    elif SessionManager.current.selected_cup == "Cup2":
        cup_2_dialogue.start_dialogue()
    else:
        cup_3_dialogue.start_dialogue()

func go_to_laundry():
    Dialogic.timeline_ended.disconnect(go_to_laundry)
    GameManager.load_level(LevelList.laundry)
