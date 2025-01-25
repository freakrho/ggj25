class_name DialogueInteractable extends Interactable

@export var timeline: DialogicTimeline

func interact():
    super()
    if Dialogic.current_timeline == null:
        Dialogic.start_timeline(timeline)
