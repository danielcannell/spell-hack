extends KinematicBody2D
class_name Enemy


signal damaged


var health := Health.new()

var ai: Array = []

const Projectile = preload("res://Playfield/Entities/Projectile.tscn")
const Swing = preload("res://Playfield/Entities/Swing.tscn")

const attack_cooldown: float = 1.0
const DEBUG_AI_GOAL = false

var current_goal = null
var next_attack_time: float = 0
var time: float = 0
var image: Texture = null
var sprite_width: float = 0
var sprite_height: float = 0
var weapon: Focus = null
var movement_speed: float = 0

onready var health_bar = $HealthBar
onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var playfield = $".."


func _ready():
    sprite.set_texture(image)
    health_bar.rect_size.x = sprite_width
    health_bar.rect_position.x = -(health_bar.rect_size.x / 2)
    health_bar.rect_position.y = -(sprite_height / 2)
    collision.shape.radius = sprite_width / 2


func get_team():
    return Globals.Team.ENEMY


func damage(dmg, type):
    var dealt := health.damage(dmg, type)
    emit_signal("damaged", self, dealt)

    if not health.alive():
        queue_free()

    update()


func add_ai(strategy: AIBase) -> void:
    ai.append(strategy)


func _draw():
    health_bar.set_value(health.value)

    if DEBUG_AI_GOAL and current_goal:
        match current_goal.type:
            GoalHelpers.Type.GO_TO:
                draw_line(Vector2(0,0), current_goal.position - position, Color.green, 2)
            GoalHelpers.Type.ATTACK_CLOSE, GoalHelpers.Type.ATTACK_SHOOT:
                draw_line(Vector2(0,0), current_goal.target.position - position, Color.red, 2)


func get_new_ai_goal() -> void:
    var goals: Array = []
    for i in range(ai.size()):
        var goal: GoalHelpers.AIGoal = ai[i].think()
        assert(goal != null)
        goals.append(goal)

    var ai_in_use: int = -1
    for i in range(goals.size()):
        var goal = goals[i]
        if goal.type == GoalHelpers.Type.IDLE:
            continue

        elif goal.type == GoalHelpers.Type.ATTACK_CLOSE or goal.type == GoalHelpers.Type.ATTACK_SHOOT:
            current_goal = goal
            break

        elif goal.type == GoalHelpers.Type.GO_TO:
            current_goal = goal
            break

        else:
            assert(false)

    if current_goal and current_goal.type == GoalHelpers.Type.IDLE:
        current_goal = null

    for i in range(ai.size()):
        if goals[i] != current_goal:
            ai[i].go_idle()

    if DEBUG_AI_GOAL:
        update()


func shoot(type, target_pos):
    var p = Projectile.instance()
    p.init(type, position, target_pos, 1e6)
    p.team = Globals.Team.ENEMY
    playfield.add_child(p)


func explode(type, target_pos):
    var initial_theta = (position - target_pos).angle()

    for i in range(Config.EXPLOSION_NUM_PROJECTILES):
        var theta = initial_theta + (i * 6.283185307) / Config.EXPLOSION_NUM_PROJECTILES
        var target = position + Vector2(cos(theta), sin(theta))
        var p = Projectile.instance()
        p.init(type, position, target, Config.EXPLOSION_PROJECTILE_RANGE)
        p.team = Globals.Team.ENEMY
        playfield.add_child(p)


func swing(focus, target_pos):
    var s = Swing.instance()
    var dir: Vector2 = target_pos - position
    s.init(focus, dir)
    s.team = Globals.Team.ENEMY
    add_child(s)
    s.position = Vector2(sign(dir.x) * 4, 4)


func attack(target: Node2D) -> void:
    if next_attack_time > time:
        return

    next_attack_time = time + attack_cooldown

    if current_goal.type == GoalHelpers.Type.ATTACK_CLOSE or current_goal.type == GoalHelpers.Type.ATTACK_SHOOT:
        var action = weapon.action().action
        print("Attack:", action)
        match action:
            Globals.Action.HIT:
                swing(weapon, target.position)
            Globals.Action.PROJECT:
                shoot(weapon.element.type, target.position)
            Globals.Action.EXPLODE:
                explode(weapon.element.type, target.position)
    else:
        assert(false)


func _physics_process(delta):
    time += delta
    get_new_ai_goal()

    if current_goal:
        if current_goal.type == GoalHelpers.Type.ATTACK_SHOOT or current_goal.type == GoalHelpers.Type.ATTACK_CLOSE:
            # Attack enemy
            attack(current_goal.target)

        elif current_goal.type == GoalHelpers.Type.GO_TO:
            # Move toward the target
            var diff: Vector2 = current_goal.position - position
            var diff_len = diff.length()

            if diff_len > 1e-6:
                var dir := diff.normalized() * movement_speed

                var progress = dir.length() * delta / diff_len
                if progress > 1:
                    dir *= 1 / progress

                move_and_slide(dir)
