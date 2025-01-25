class_name ChooseCupCondition extends MinigameCondition

@export var choices: Array[AreaSelectable]


func _ready():
    for choice in choices:
        choice.connect("selected", on_selected)

func on_selected(selectable: AreaSelectable) -> void:
    completed = true
    SessionManager.current.selected_cup = selectable.name
