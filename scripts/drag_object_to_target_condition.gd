class_name DraggObjectToTargetCondition extends MinigameCondition

signal on_drop()

@export var reset_if_failed: bool
@export var draggable: Draggable
@export var slideable: Slideable
@export var target: Area2D
@export var wait_time: float

var timer: Timer
var blocked := false

func _ready() -> void:
    if reset_if_failed:
        if slideable != null:
            slideable.dropped.connect(_on_drop)
        else:
            draggable.dropped.connect(_on_drop)
    if timer == null:
        timer = Timer.new()
        add_child(timer)
        timer.timeout.connect(_on_timeout)

func _on_drop():
    if slideable != null:
        if !dependency_complete() or !target.overlaps_area(slideable.knob):
            slideable.reset()
            return
    else:
        if !dependency_complete() or !target.overlaps_area(draggable):
            draggable.reset()
            return
    if wait_time > 0:
        timer.start()
        blocked = true
    on_drop.emit()

func condition_met() -> bool:
    if blocked:
        return false
    if slideable != null:
        return target.overlaps_area(slideable.knob) and not slideable.dragging
    return target.overlaps_area(draggable) and not draggable.dragging

func _on_timeout():
    blocked = false
