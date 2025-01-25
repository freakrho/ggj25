class_name Interactable extends Area2D

signal Interaction

func _ready() -> void:
    connect("body_entered", _on_body_entered)
    connect("body_exited", _on_body_exited)
    connect("input_event", _on_input_event)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    # Send player here and then interact
    pass

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.interactable_entered(self)


func _on_body_exited(body: Node2D) -> void:
    if body is Player:
        body.interactable_exited(self)


func interact():
    Interaction.emit()
