extends Node2D

@export var player: Player
@export var nav_map: NavigationRegion2D

func _ready() -> void:
    # Create a new navigation map.
    var map: RID = NavigationServer2D.map_create()
    NavigationServer2D.map_set_active(map, true)
    NavigationServer2D.region_set_map(nav_map, map)
    player.set_navigation_map(map)
