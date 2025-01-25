class_name MinigameCondition extends Node

var completed: bool

func complete():
    completed = true
    print("COMPLETED %s" % name)

func condition_met() -> bool:
    return false
    
