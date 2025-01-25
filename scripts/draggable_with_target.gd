class_name DraggableWithTarget extends Draggable

@export var target: Interactable

func _ready() -> void:
    super()
    dropped.connect(on_dropped)
    
func on_dropped():
    if target.overlaps_area(self):
        GameManager.player.go_to_and_interact(target)
    reset()
