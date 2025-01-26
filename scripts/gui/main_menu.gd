extends Control


@export var pause_panel: PackedScene


func _on_button_play_pressed() -> void:
    GameManager.load_level(LevelList.room)
    get_tree().root.add_child(pause_panel.instantiate())
    queue_free()


func _on_button_credits_pressed() -> void:
    pass # Replace with function body.


func _on_button_quit_pressed() -> void:
    get_tree().quit()
