class_name Draggable extends StaticBody2D

var dragging: bool = false
var rel_position: Vector2

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index != MOUSE_BUTTON_LEFT:
            return
            
        if event.pressed and not dragging:
            _start_dragging(event.position)
            
        elif not event.pressed and dragging:
            _end_dragging()

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
