extends MinigameCondition

@export var accepted_coins: Array[int] = [ 1 ]
@export var expected_amount: int = 5
@export var drop_area: Area2D
@export var coin_positions: Array[Node2D]
@export var coin_1: PackedScene
@export var coin_2: PackedScene
@export var coin_5: PackedScene
@export var label: Label

var initial_coins: Array[Coin] = []
var taken_coins: Array[Coin] = []
var current_coin: Coin

func value_loaded() -> int:
    var value = 0
    for coin in taken_coins:
        if coin == null:
            continue
        value += coin.value
    return value

func _ready() -> void:
    drop_area.area_entered.connect(_on_body_entered)
    drop_area.area_exited.connect(_on_body_entered)

func _enter_tree() -> void:
    # spawn initial coins
    for coin in initial_coins:
        coin.queue_free()
    initial_coins.clear()
    
    var positions: Array[int] = []
    for i in range(coin_positions.size()):
        positions.append(i)
    
    for coin_value in SessionManager.current.coins:
        var coin: Coin
        if coin_value == 1:
            coin = coin_1.instantiate()
        elif coin_value == 2:
            coin = coin_2.instantiate()
        elif coin_value == 5:
            coin = coin_5.instantiate()
        add_child(coin)
        initial_coins.append(coin)
        var rand = randi_range(0, positions.size() - 1)
        var p = positions[rand]
        positions.remove_at(rand)
        var position = coin_positions[p]
        coin.global_position = position.global_position

func _on_body_exited(body: Node2D):
    if body == current_coin:
        current_coin.dropped.disconnect(_on_dropped_coin)
        current_coin = null

func _on_body_entered(body: Node2D):
    if body is Coin and body != current_coin:
        current_coin = body
        current_coin.dropped.connect(_on_dropped_coin)

func _on_dropped_coin():
    if current_coin.value in accepted_coins:
        _take_coin(current_coin)
        return
    current_coin.dropped.disconnect(_on_dropped_coin)
    current_coin.reset()

func _take_coin(coin: Coin):
    taken_coins.append(coin)
    coin.get_parent().remove_child(coin)
    _validate_value()
    coin.dropped.disconnect(_on_dropped_coin)
    current_coin = null
    
func _validate_value():
    var value = value_loaded()
    if value > expected_amount:
        # reset puzzle
        for coin in taken_coins:
            coin.reset()
        label.text = "00"
    else:
        label.text = "%02d" % value

func condition_met() -> bool:
    return value_loaded() == expected_amount
