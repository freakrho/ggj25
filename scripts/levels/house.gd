extends Level

@export var office_scene: PackedScene

func go_out():
    GameManager.load_level(office_scene)
