class_name DialogueSettings extends Node

@export var dialogue: DialogicTimeline

func start_dialogue():
    Dialogic.Styles.load_style(GlobalDialogueSettings.dialogue_style.name)
    var layout = Dialogic.start(dialogue)
    register_characters.call_deferred(layout)

func register_characters(layout):
    for character in GameManager.current_level.characters:
        layout.register_character(character.character, character.node)
    
    layout.register_character(GameManager.player.dialogue_character,
        GameManager.player.dialogue_marker)
