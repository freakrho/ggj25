extends Level


@export var thanks_for_playing_scene: PackedScene


func end_game():
    get_tree().root.add_child(thanks_for_playing_scene.instantiate())
    queue_free()
