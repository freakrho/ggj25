extends Control


func _on_button_play_pressed() -> void:
    GameManager.load_level(LevelList.room)
    queue_free()


func _on_button_credits_pressed() -> void:
    pass # Replace with function body.


func _on_button_quit_pressed() -> void:
    get_tree().quit()
