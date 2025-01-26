class_name DialogueSettings extends Node


signal on_end_dialogue()


@export var dialogue: DialogicTimeline


func start_dialogue():
    Dialogic.Styles.load_style(GlobalDialogueSettings.dialogue_style.name)
    var layout = Dialogic.start(dialogue)
    register_characters.call_deferred(layout)
    Dialogic.timeline_ended.connect(_on_dialogue_end)

func register_characters(layout):
    for character in GameManager.current_level.characters:
        layout.register_character(character.character, character.node)
    
    layout.register_character(GameManager.player.dialogue_character,
        GameManager.player.dialogue_marker)
    
    for character in SessionManager.current.killed:
        var char_name = character.resource_path.get_file()
        char_name = char_name.substr(0, len(char_name) - len(char_name.get_extension()) - 1)
        var variables = Dialogic.get_subsystem("VAR")
        variables.set_variable("%s_dead" % char_name, true)


func _on_dialogue_end():
    on_end_dialogue.emit()
    Dialogic.timeline_ended.disconnect(_on_dialogue_end)
