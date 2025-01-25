class_name AreaSelectable extends Area2D

signal selected(obj: AreaSelectable)

func _ready() -> void:
    connect("input_event", _on_input_event)

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            viewport.set_input_as_handled()
            selected.emit(self)
