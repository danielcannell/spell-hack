extends KinematicBody2D

signal player_death

signal damaged


var health := Health.new()

onready var health_bar = $HealthBar
onready var hat = $Hat
onready var sprite = $Sprite


func get_team():
    return Globals.Team.PLAYER


func damage(dmg, type):
    var dealt := health.damage(dmg, type)
    emit_signal("damaged", self, dealt)


func on_heal(amt):
    emit_signal("damaged", self, -amt)


func set_passives(rs, bs):
    health.set_passives(rs, bs)


func on_equip(focus):
    if focus.type == Globals.FocusType.HAT:
        hat.visible = true
        health_bar.rect_position.y = -23


func get_input():
    var velocity = Vector2()

    if Input.is_action_pressed("player_up"):
        velocity.y -= 1
    if Input.is_action_pressed("player_down"):
        velocity.y += 1
    if Input.is_action_pressed("player_left"):
        velocity.x -= 1
    if Input.is_action_pressed("player_right"):
        velocity.x += 1

    return velocity.normalized() * Config.PLAYER_SPEED * health.speed_boost()


func _ready():
    health.connect("on_heal", self, "on_heal")


func _physics_process(delta):
    var velocity = get_input()

    if velocity.x > 0:
        hat.flip_h = false
        hat.offset.x = -1
        sprite.flip_h = false
    elif velocity.x < 0:
        hat.flip_h = true
        hat.offset.x = 1
        sprite.flip_h = true

    move_and_slide(velocity)


func _process(delta):
    health.process(delta)
    health_bar.set_value(health.value)
    if not health.alive():
        emit_signal("player_death")
