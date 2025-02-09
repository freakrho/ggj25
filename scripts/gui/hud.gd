class_name HUD extends Control


@export var action_label: Label


func _ready() -> void:
    action_label.hide()


func set_action_text(text: String):
    action_label.show()
    action_label.text = text


func hide_action_text(text: String):
    if action_label.text == text:
        action_label.hide()

func reset():
    action_label.hide()
