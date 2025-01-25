class_name DraggObjectToTargetCondition extends MinigameCondition

@export var draggable: Draggable
@export var slideable: Slideable
@export var target: Area2D

func condition_met() -> bool:
    if slideable != null:
        return target.overlaps_body(slideable.knob) and not slideable.dragging
    return target.overlaps_body(draggable) and not draggable.dragging
