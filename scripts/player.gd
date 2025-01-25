class_name Player extends CharacterBody2D

@export var move_speed: float = 300
@export var nav_agent: NavigationAgent2D

var moving := false
var interactables: Array[Interactable] = []

func _ready() -> void:
    nav_agent.velocity_computed.connect(Callable(_on_velocity_computed))
    nav_agent.max_speed = move_speed
    
func set_navigation_map(map: RID):
    nav_agent.set_navigation_map(map)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            set_target(event.position)
            
func set_target(target: Vector2):
    nav_agent.target_position = target
    moving = true

func end_navigation():
    moving = false
    nav_agent.velocity = Vector2.ZERO

func process_navigation(delta: float):
    # Do not query when the map has never synchronized and is empty.
    if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
        return
    if nav_agent.is_navigation_finished():
        end_navigation()
        return
    
    var next_path_position: Vector2 = nav_agent.get_next_path_position()
    var new_velocity: Vector2 = global_position.direction_to(next_path_position) * move_speed
    if nav_agent.avoidance_enabled:
        nav_agent.set_velocity(new_velocity)
    else:
        _on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
    velocity = safe_velocity
    #global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

func _physics_process(delta: float) -> void:
    # Interaction
    if Input.is_action_just_pressed("interact"):
        for interactable in interactables:
            interactable.interact()
    
    # Movement
    if moving:
        process_navigation(delta)
    
    var movement = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if movement.length_squared() > 0:
        end_navigation()
        velocity = movement * move_speed
    
    move_and_slide()

func interactable_entered(interactable: Interactable):
    interactables.append(interactable)

func interactable_exited(interactable: Interactable):
    for i in range(interactables.size() - 1, -1, -1):
        if interactables[i] == interactable:
            interactables.remove_at(i)
