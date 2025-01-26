extends Level

@export var character_mugs: Array[CharacterPair]
@export var coins_per_day: Array[Array]

func _ready() -> void:
    super()
    for pair in character_mugs:
        print(pair.character not in SessionManager.current.killed)
        if pair.character not in SessionManager.current.killed:
            pair.node.get_parent().remove_child(pair.node)
    # set coins
    SessionManager.current.coins = coins_per_day[min(coins_per_day.size() -1, SessionManager.current.day)]

func go_to_front():
    GameManager.load_level(LevelList.house)
