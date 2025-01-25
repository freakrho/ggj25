extends Level

@export var door: Interactable
@export var washing_machine_minigame: Minigame
@export var room: PackedScene

func _ready() -> void:
    super()
    washing_machine_minigame.Ended.connect(_on_ended)
    door.get_parent().remove_child(door)

func _on_ended(minigame: Minigame):
    add_child(door)


func _on_door_interaction() -> void:
    GameManager.load_level(room)
