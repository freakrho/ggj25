extends Level

@export var door: Interactable
@export var washing_machine_minigame: Minigame

func _ready() -> void:
    super()
    washing_machine_minigame.Ended.connect(_on_ended)
    door.get_parent().remove_child(door)

func _on_ended(minigame: Minigame):
    add_child(door)


func _on_door_interaction() -> void:
    SessionManager.current.new_day()
    if SessionManager.current.day >= GlobalDialogueSettings.final_day:
        GameManager.load_level(LevelList.final)
    else:
        GameManager.load_level(LevelList.room)
