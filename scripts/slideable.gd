class_name Slideable extends Node2D

@export var path: Path2D
@export var knob: RigidBody2D
@export var max_delta: float = 20

var dragging: bool = false
var rel_position: Vector2


func _on_knob_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
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
        # Find closest point in path
        var point = event.position - rel_position
        path.curve.get
        point = path.to_global(path.curve.get_closest_point(path.to_local(point)))
        if (point - knob.global_position).length_squared() <= max_delta * max_delta:
            knob.global_position = point

func _start_dragging(mouse_pos: Vector2):
    dragging = true
    rel_position = knob.global_position - mouse_pos

func _end_dragging():
    dragging = false
