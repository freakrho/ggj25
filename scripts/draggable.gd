class_name Draggable extends Area2D

signal dropped()

var dragging: bool = false
var rel_position: Vector2
var initial_parent: Node
var initial_position: Vector2

func _ready() -> void:
    initial_parent = get_parent()
    initial_position = position
    input_event.connect(_on_input_event)
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
    if !GameManager.input_enabled():
        return
    if event is InputEventMouseButton:
        if event.button_index != MOUSE_BUTTON_LEFT:
            return
        if event.pressed and not dragging:
            _start_dragging(event.position)
        elif not event.pressed and dragging:
            _end_dragging()
        
        viewport.set_input_as_handled()

func _input(event: InputEvent) -> void:
    if not dragging:
        return
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
            _end_dragging()
    elif event is InputEventMouseMotion:
        global_position = event.position - rel_position

func _start_dragging(mouse_pos: Vector2):
    dragging = true
    rel_position = global_position - mouse_pos

func _end_dragging():
    dragging = false
    dropped.emit()

func reset():
    if get_parent() != initial_parent:
        if get_parent() == null:
            initial_parent.add_child(self)
        else:
            reparent(initial_parent)
    position = initial_position

func _on_mouse_entered():
    if GameManager.input_enabled():
        Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
        SoundManager.hover_player.play()

func _on_mouse_exited():
    Input.set_default_cursor_shape(Input.CURSOR_ARROW)
