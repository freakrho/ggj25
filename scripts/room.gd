extends Level

@export var front_scene: PackedScene

func go_to_front():
    GameManager.load_level(front_scene)
