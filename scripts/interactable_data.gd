class_name InteractableData extends Node


@export var action_text: String


func show_action():
    GameManager.set_active_interactable(self)


func hide_action():
    GameManager.unset_active_interactable(self)
