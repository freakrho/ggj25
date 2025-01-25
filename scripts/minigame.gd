class_name Minigame extends Node2D

@export var sorted_conditions: Array[MinigameCondition]
@export var independent_conditions: Array[MinigameCondition]

func _process(delta: float) -> void:
    for condition in sorted_conditions:
        if condition.completed:
            continue
        if condition.condition_met():
            condition.complete()
        break
    for condition in independent_conditions:
        if not condition.completed and condition.condition_met():
            condition.complete()
            
    if all_conditions_completed():
        print("ENDED")

func all_conditions_completed() -> bool:
    for condition in sorted_conditions:
        if !condition.completed:
            return false
    for condition in independent_conditions:
        if !condition.completed:
            return false
    return true

func start_minigame():
    GameManager.current_level.open_minigame(self)
