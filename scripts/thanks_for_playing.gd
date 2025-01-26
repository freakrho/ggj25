extends Control


func _on_button_play_pressed() -> void:
    GameManager.go_to_main_menu()
    queue_free()


func _on_button_quit_pressed() -> void:
    get_tree().quit()
