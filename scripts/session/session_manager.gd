extends Node

var current: Session

func new_session():
    current = Session.new()
    current.coins = [ 1, 2, 5 ]
    #current.coins = [ 5 ]

func _init() -> void:
    print("New session")
    new_session()
