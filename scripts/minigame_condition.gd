class_name MinigameCondition extends Node

@export var depends_on: Array[MinigameCondition]

var completed: bool

func complete():
    completed = true
    print("COMPLETED %s" % name)

func dependency_complete() -> bool:
    for dep in depends_on:
        if not dep.completed:
            return false
    return true

func condition_met() -> bool:
    return false

func can_complete() -> bool:
    return dependency_complete() and condition_met()
