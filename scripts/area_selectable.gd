class_name AreaSelectable extends Area2D

signal selected(obj: AreaSelectable)

func _ready() -> void:
    connect("input_event", _on_input_event)
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

func _on_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            viewport.set_input_as_handled()
            selected.emit(self)

func _on_mouse_entered():
    if GameManager.input_enabled():
        SoundManager.hover_player.play()
        Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
    Input.set_default_cursor_shape(Input.CURSOR_ARROW)
