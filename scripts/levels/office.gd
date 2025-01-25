extends Level

@export var laundry_scene: PackedScene

func go_to_laundry():
    GameManager.load_level(laundry_scene)
