class_name DialogueSettings extends Node

@export var dialogue: DialogicTimeline
@export var characters: Array[CharacterPair]

func start_dialogue():
    Dialogic.Styles.load_style(GlobalDialogueSettings.dialogue_style.name)
    var layout = Dialogic.start(dialogue)
    
    for character in characters:
        layout.register_character(character.character, character.node)
    layout.register_character(GameManager.player.dialogue_character,
        GameManager.player.dialogue_marker)
