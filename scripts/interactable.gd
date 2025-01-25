class_name Interactable extends Area2D

signal Interaction

@export var default_position: Node2D

func _ready() -> void:
    connect("body_entered", _on_body_entered)
    connect("body_exited", _on_body_exited)
    connect("input_event", _on_input_event)


func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            # Send player here and then interact
            GameManager.player.go_to_and_interact(self)
            viewport.set_input_as_handled()

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.interactable_entered(self)


func _on_body_exited(body: Node2D) -> void:
    if body is Player:
        body.interactable_exited(self)


func interact():
    Interaction.emit()
