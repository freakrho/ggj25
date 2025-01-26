extends Control

@export var pause_panel: Control


func _ready() -> void:
    pause_panel.hide()


func _on_button_play_pressed() -> void:
    pause_panel.hide()
    get_tree().paused = false


func _on_button_main_menu_pressed() -> void:
    GameManager.go_to_main_menu()
    queue_free()


func _on_button_quit_pressed() -> void:
    get_tree().quit()


func _on_pause_button_pressed() -> void:
    pause_panel.show()
    get_tree().paused = true
