extends Level

@export var character_mugs: Array[CharacterPair]

func _ready() -> void:
    super()
    for pair in character_mugs:
        print(pair.character not in SessionManager.current.killed)
        if pair.character not in SessionManager.current.killed:
            pair.node.get_parent().remove_child(pair.node)

func go_to_front():
    GameManager.load_level(LevelList.house)
