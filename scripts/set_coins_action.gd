extends Node

@export var coins: Array[int]

func set_coins():
    SessionManager.current.coins = coins
