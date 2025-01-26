extends Control


@export var pause_panel: PackedScene
@export var credits: Control


func _ready() -> void:
    credits.hide()


func _on_button_play_pressed() -> void:
    SessionManager.new_session()
    GameManager.load_level(LevelList.room)
    get_tree().root.add_child(pause_panel.instantiate())
    queue_free()


func _on_button_credits_pressed() -> void:
    if credits.visible:
        credits.hide()
    else:
        credits.show()


func _on_button_quit_pressed() -> void:
    get_tree().quit()
