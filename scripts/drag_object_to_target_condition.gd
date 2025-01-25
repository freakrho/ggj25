class_name DraggObjectToTargetCondition extends MinigameCondition

@export var reset_if_failed: bool
@export var draggable: Draggable
@export var slideable: Slideable
@export var target: Area2D

func _ready() -> void:
    if reset_if_failed:
        if slideable != null:
            slideable.dropped.connect(_on_drop)
        else:
            draggable.dropped.connect(_on_drop)

func _on_drop():
    if slideable != null:
        if !dependency_complete() or !target.overlaps_area(slideable.knob):
            slideable.reset()
    else:
        if !dependency_complete() or !target.overlaps_area(draggable):
            draggable.reset()

func condition_met() -> bool:
    if slideable != null:
        return target.overlaps_area(slideable.knob) and not slideable.dragging
    return target.overlaps_area(draggable) and not draggable.dragging
