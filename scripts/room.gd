extends Level

@export var start_dialog: DialogicTimeline
@export var front_scene: PackedScene


func _ready() -> void:
    super()
    Dialogic.start_timeline(start_dialog)

func go_to_front():
    GameManager.load_level(front_scene)
