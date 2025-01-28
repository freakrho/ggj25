extends Level

@export var killables: Array[KillableConfig]


func _ready() -> void:
    super()
    for killable in killables:
        killable.remove_if_dead()

func _on_coffee_minigame_ended(minigame: Minigame) -> void:
    for killable in killables:
        killable.remove_if_dead()
    minigame.close_minigame()
    end_sequence()

func end_sequence():
    Dialogic.timeline_ended.connect(go_to_laundry)
    for killable in killables:
        if killable.character == SessionManager.current.selected_for_killing:
            killable.dialogue.start_dialogue()

func go_to_laundry():
    Dialogic.timeline_ended.disconnect(go_to_laundry)
    GameManager.load_level.call_deferred(LevelList.laundry)
