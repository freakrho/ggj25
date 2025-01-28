extends Node2D


@export var thanks_for_playing_scene: PackedScene
@export var wait_time: float = 3

var timer: Timer

func _ready() -> void:
    timer = Timer.new()
    add_child(timer)
    timer.wait_time = wait_time
    timer.timeout.connect(_on_timeout)
    timer.start()

func _on_timeout():
    timer.stop()
    
func end_game():
    get_tree().root.add_child(thanks_for_playing_scene.instantiate())
    queue_free()


func _input(event: InputEvent) -> void:
    if event.is_action("interact") or event is InputEventMouseButton:
        if timer.is_stopped():
            end_game()
