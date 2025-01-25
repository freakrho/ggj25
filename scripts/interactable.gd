class_name Interactable extends Area2D

signal Interaction

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.interactable_entered(self)


func _on_body_exited(body: Node2D) -> void:
    if body is Player:
        body.interactable_exited(self)

func interact():
    Interaction.emit()
