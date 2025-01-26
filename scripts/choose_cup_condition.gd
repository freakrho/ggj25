class_name ChooseCupCondition extends MinigameCondition

@export var choices: Array[AreaSelectable]
@export var characters: Array[DialogicCharacter]
@export var cups_on_table: Array[Node2D]


var selected: AreaSelectable
var cup_parent: Node


func _ready():
    cup_parent = choices[0].get_parent()
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
    selected = selectable
    for i in range(choices.size()):
        if choices[i] == selectable:
            cups_on_table[i].show()
        else:
            if choices[i].get_parent() == null:
                cup_parent.add_child(choices[i])
            cups_on_table[i].hide()

func do_effect(minigame: Minigame):
    for i in range(choices.size()):
        if choices[i] == selected:
            SessionManager.current.kill(characters[i])
            return
