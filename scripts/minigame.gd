class_name Minigame extends Node2D

signal Ended(minigame: Minigame)

@export var sorted_conditions: Array[MinigameCondition]
@export var independent_conditions: Array[MinigameCondition]

var ended: bool

func _process(delta: float) -> void:
    if ended:
        return
    
    for condition in sorted_conditions:
        if condition.completed:
            continue
        if condition.can_complete():
            condition.complete()
        break
    for condition in independent_conditions:
        if not condition.completed and condition.can_complete():
            condition.complete()
            
    if all_conditions_completed():
        ended = true
        Ended.emit(self)

func all_conditions_completed() -> bool:
    for condition in sorted_conditions:
        if !condition.completed:
            return false
    for condition in independent_conditions:
        if !condition.completed:
            return false
    return true

func start_minigame():
    ended = false
    GameManager.current_level.open_minigame(self)

func close_minigame():
    GameManager.current_level.close_minigame(self)
