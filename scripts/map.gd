class_name Map extends Node2D

@export var player: Player
@export var nav_map: NavigationRegion2D
@export var interactable_area: Area2D

var map: RID

func _ready() -> void:
    interactable_area.input_event.connect(player.world_input_event)

func setup():
    # Create a new navigation map.
    map = NavigationServer2D.map_create()
    NavigationServer2D.map_set_active(map, true)
    set_map()

func set_map():
    NavigationServer2D.region_set_map(nav_map, map)
    player.set_navigation_map(map)

func hide_map():
    if nav_map.get_parent() == self:
        remove_child(nav_map)

func show_map():
    if nav_map.get_parent() != null:
        nav_map.reparent(self)
    else:
        add_child(nav_map)
    set_map()
