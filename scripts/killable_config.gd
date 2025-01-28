class_name KillableConfig extends Node

@export var character: DialogicCharacter
@export var nodes_to_remove_when_dead: Array[Node]
@export var nodes_to_remove_when_selected_for_killing: Array[Node]
@export var dialogue: DialogueSettings

func remove_soft():
    for node in nodes_to_remove_when_selected_for_killing:
        if node.get_parent() != null:
            node.get_parent().remove_child(node)

func remove_if_dead():
    # character was just selected
    if SessionManager.current.selected_for_killing == character:
        remove_soft()
    else:  # if character is dead
        if SessionManager.current.is_dead(character):
            remove_soft()
            for node in nodes_to_remove_when_dead:
                if node.get_parent() != null:
                    node.get_parent().remove_child(node)
