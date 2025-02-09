class_name Player extends CharacterBody2D

@export var move_speed: float = 300
@export var nav_agent: NavigationAgent2D
@export var dialogue_character: DialogicCharacter
@export var dialogue_marker: Node2D
@export var animator: AnimatedSprite2D

var moving := false
var interactables: Array[Interactable] = []
var target_interactable: Interactable

func _ready() -> void:
    nav_agent.velocity_computed.connect(Callable(_on_velocity_computed))
    nav_agent.max_speed = move_speed
    GameManager.player = self
    animator.play("idle")

func set_navigation_map(map: RID):
    nav_agent.set_navigation_map(map)

func world_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
    if !GameManager.input_enabled():
        return
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            target_interactable = null
            set_target(event.position)
            viewport.set_input_as_handled()

func set_target(target: Vector2):
    nav_agent.target_position = target
    moving = true

func end_navigation():
    moving = false
    nav_agent.velocity = Vector2.ZERO
    if target_interactable != null:
        target_interactable.interact()

func process_navigation():
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

func _update_anim() -> void:
    if velocity.length_squared() > 0:
        animator.play("walk")
        animator.flip_h = velocity.x < 0
    else:
        animator.play("idle")
        animator.flip_h = false

func _physics_process(_delta: float) -> void:
    if !GameManager.input_enabled():
        _update_anim()
        return

    # Interaction
    if Input.is_action_just_pressed("interact"):
        for interactable in interactables:
            interactable.interact()

    # Movement
    if moving:
        process_navigation()

    var movement = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if movement.length_squared() > 0:
        target_interactable = null
        end_navigation()
        velocity = movement * move_speed

    _update_anim()
    move_and_slide()

func interactable_entered(interactable: Interactable):
    interactables.append(interactable)

func interactable_exited(interactable: Interactable):
    for i in range(interactables.size() - 1, -1, -1):
        if interactables[i] == interactable:
            interactables.remove_at(i)

func go_to_and_interact(interactable: Interactable):
    if target_interactable == interactable:
        return
    target_interactable = interactable
    set_target(interactable.default_position.global_position)
