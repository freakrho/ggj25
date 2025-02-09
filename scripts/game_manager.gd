extends Node

@onready var main_menu: PackedScene = load("res://scenes/main_menu.tscn")

var current_level: Level
var hud: HUD
var player: Player
var level_node: Node2D
var hud_node: Node


func _ready() -> void:
    level_node = Node2D.new()
    add_child(level_node)
    hud_node = Node.new()
    add_child(hud_node)


func load_hud():
    if hud == null:
        hud = LevelList.hud.instantiate()
        hud_node.add_child(hud)


func set_current_level(level: Level):
    if current_level == level:
        return
    current_level = level
    current_level.reparent.call_deferred(level_node)
    load_hud()


func load_level(level_scene: PackedScene):
    if current_level != null:
        current_level.queue_free()
    var level = level_scene.instantiate()
    level_node.add_child(level)
    load_hud()
    hud.reset()


func input_enabled() -> bool:
    return Dialogic.current_timeline == null


func go_to_main_menu():
    if current_level != null and not current_level.is_queued_for_deletion():
        current_level.queue_free()
    if hud != null and not hud.is_queued_for_deletion():
        hud.queue_free()
    get_tree().root.add_child(main_menu.instantiate())


func set_active_interactable(data: InteractableData):
    hud.set_action_text(data.action_text)


func unset_active_interactable(data: InteractableData):
    hud.hide_action_text(data.action_text)
