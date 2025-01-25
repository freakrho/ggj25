class_name PressButtonCondition extends MinigameCondition

@export var button: Button

var pressed := false

func _ready() -> void:
    button.pressed.connect(_on_pressed)

func _on_pressed():
    if dependency_complete():
        pressed = true

func condition_met():
    return pressed
