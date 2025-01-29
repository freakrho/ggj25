extends Node

var current: Session

func new_session():
    current = Session.new()
    current.init.call_deferred()

func _init() -> void:
    print("New session")
    new_session()
