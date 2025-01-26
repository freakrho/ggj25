class_name Session extends RefCounted

var selected_for_killing: DialogicCharacter
var killed: Array[DialogicCharacter]
var coins: Array[int]
var day: int

func kill(character: DialogicCharacter):
    selected_for_killing = character
    killed.append(character)

func new_day():
    day += 1
    var variables = Dialogic.get_subsystem("VAR")
    variables.set_variable("day", day)
