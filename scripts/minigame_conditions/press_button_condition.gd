class_name PressButtonCondition extends MinigameCondition

signal on_pressed()

@export var button: Button
@export var wait_time: float

var pressed := false
var timer: Timer

func _ready() -> void:
    button.pressed.connect(_on_pressed)
    if timer == null:
        timer = Timer.new()
        add_child(timer)
        timer.timeout.connect(_on_timeout)

func _on_pressed():
    if dependency_complete():
        if wait_time > 0:
            timer.wait_time = wait_time
            timer.start()
        else:
            pressed = true
        on_pressed.emit()

func _on_timeout():
    pressed = true

func condition_met():
    return pressed
