extends KinematicBody2D


var speed = 100
var health = 100


onready var health_bar = $HealthBar
onready var hat = $Hat


func get_team():
    return Globals.Team.PLAYER


func damage(dmg):
    health = max(0, health - dmg)


func set_hat(enabled):
    hat.visible = enabled

    if enabled:
        health_bar.rect_position.y = -23
    else:
        health_bar.rect_position.y = -11


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

    return velocity.normalized() * speed


func _ready():
    pass


func _physics_process(delta):
    var velocity = get_input()
    move_and_slide(velocity)


func _process(delta):
    health_bar.set_value(health)
