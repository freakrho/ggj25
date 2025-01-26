extends Node


func set_coins():
    # create enough change to have 3 $1 coins
    var total = 0
    for i in range(SessionManager.current.coins.size() - 1, -1, -1):
        var coin = SessionManager.current.coins[i]
        total += coin
        SessionManager.current.coins.remove_at(i)
        if total >= 3:
            break
    for i in range(total):
        SessionManager.current.coins.append(1)
