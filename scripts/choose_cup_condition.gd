class_name ChooseCupCondition extends MinigameCondition

@export var choices: Array[AreaSelectable]
@export var characters: Array[DialogicCharacter]
@export var cups_on_table: Array[Node2D]

func _ready():
    for cup in cups_on_table:
        cup.hide()
    for i in range(characters.size()):
        var choice = choices[i]
        if characters[i] in SessionManager.current.killed:
            choice.get_parent().remove_child(choice)
        else:
            choice.selected.connect(on_selected)

func on_selected(selectable: AreaSelectable) -> void:
    completed = true
    selectable.get_parent().remove_child(selectable)
    for i in range(choices.size()):
        if choices[i] == selectable:
            SessionManager.current.kill(characters[i])
            cups_on_table[i].show()
            return
