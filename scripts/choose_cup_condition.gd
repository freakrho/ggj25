class_name ChooseCupCondition extends MinigameCondition

@export var choices: Array[AreaSelectable]
@export var characters: Array[DialogicCharacter]


func _ready():
    for choice in choices:
        choice.connect("selected", on_selected)

func on_selected(selectable: AreaSelectable) -> void:
    completed = true
    for i in range(choices.size()):
        if choices[i] == selectable:
            SessionManager.current.kill(characters[i])
            return
