extends Node2D

onready var playfield = $ViewportContainer/Viewport/Playfield
onready var player = $ViewportContainer/Viewport/Playfield.player
onready var magic = $Magic
onready var focus_editor = $UI/CanvasLayer2/FocusEditor
onready var ui = $UI
onready var tutorial = $Tutorial


func _ready():
    focus_editor.connect("disenchant", magic, "_on_disenchant")
    focus_editor.connect("equip", magic, "_on_focus_equip")
    focus_editor.connect("enchant", magic, "_on_enchant")
    focus_editor.connect("equip", player, "on_equip")

    magic.connect("inventory_changed", ui, "on_inventory_changed")
    magic.connect("active", playfield, "on_equip_active")
    magic.connect("passive", playfield, "on_equip_passive")

    playfield.connect("item_picked_up", magic, "_on_item_pickup")

    player.connect("player_death", ui, "on_player_death")

    magic.inventory.connect("tutorial_event", tutorial, "handle_tutorial_event")
    focus_editor.connect("tutorial_event", tutorial, "handle_tutorial_event")


func _process(delta):
    var size := get_viewport_rect().size - Vector2(180, 0)
    $ViewportContainer.rect_size = size
    $ViewportContainer/Viewport.size = size
