class_name Session extends RefCounted

var selected_for_killing: DialogicCharacter
var killed: Array[DialogicCharacter]
var coins: Array
var day: int
var variables

func init():
    variables = Dialogic.get_subsystem("VAR")
    sync_data_with_dialogic()

func kill(character: DialogicCharacter):
    selected_for_killing = character
    killed.append(character)
    set_killed_var(character, true)

func new_day():
    day += 1
    selected_for_killing = null
    sync_data_with_dialogic()

func is_dead(character: DialogicCharacter):
    return character in killed

func set_killed_var(character: DialogicCharacter, state: bool):
    var char_name = character.resource_path.get_file()
    char_name = char_name.substr(0, len(char_name) - len(char_name.get_extension()) - 1)
    variables.set_variable("%s_dead" % char_name, state)

func sync_data_with_dialogic():
    variables.set_variable("day", day + 1)
    for character in GlobalDialogueSettings.killable_characters:
        set_killed_var(character, false)
    for character in killed:
        set_killed_var(character, true)
    
