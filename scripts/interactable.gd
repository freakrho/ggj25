class_name Interactable extends Area2D

signal Interaction

@export var default_position: Node2D
@export var dialogue: DialogueSettings
@export var dialogues: Array[DialogueSettings]

var last_dialogue: int = 0
var interactable_data: InteractableData

func _ready() -> void:
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)
    input_event.connect(_on_input_event)
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)
    var children = find_children("*", "InteractableData") as Array[InteractableData]
    if children.size() > 0:
        interactable_data = children[0]

func _on_input_event(viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            # Send player here and then interact
            GameManager.player.go_to_and_interact(self)
            viewport.set_input_as_handled()
            SoundManager.interaction_player.play()

func _on_mouse_entered():
    if GameManager.input_enabled():
        SoundManager.hover_player.play()
        Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
        if interactable_data != null:
            interactable_data.show_action()

func _on_mouse_exited():
    Input.set_default_cursor_shape(Input.CURSOR_ARROW)
    if interactable_data != null:
        interactable_data.hide_action()

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.interactable_entered(self)


func _on_body_exited(body: Node2D) -> void:
    if body is Player:
        body.interactable_exited(self)


func interact():
    if dialogue == null and dialogues.size() == 0:
        do_interaction()
    else:
        if dialogue != null:
            dialogue.start_dialogue()
        else:
            dialogues[last_dialogue].start_dialogue()
            if last_dialogue < dialogues.size() - 1:
                last_dialogue += 1
        Dialogic.timeline_ended.connect(ended_dialoge)


func do_interaction():
    Interaction.emit()


func ended_dialoge():
    Dialogic.timeline_ended.disconnect(ended_dialoge)
    do_interaction()
