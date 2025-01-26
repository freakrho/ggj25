extends Control

@export var pause_panel: Control


func _ready() -> void:
    remove_child(pause_panel)


func _on_button_play_pressed() -> void:
    remove_child(pause_panel)
    get_tree().paused = false


func _on_button_main_menu_pressed() -> void:
    GameManager.go_to_main_menu()
    queue_free()


func _on_button_quit_pressed() -> void:
    get_tree().quit()


func _on_pause_button_pressed() -> void:
    add_child(pause_panel)
    get_tree().paused = true
