extends Node

# You can find these in the world
enum WorldItem {
    STICK,
    WAND,
    STAFF,
    HAT,
    RING,

    FIRE,
    WATER,
    ROCK,
    WIND,

    _MAX,
}

enum FocusType {
    HAT,
    RING,
    WEAPON,

    _MAX
}

enum Foci {
    STICK,  # Hits things
    WAND,   # Shoots things
    STAFF,  # Explodes
    HAT,    # Enhances
    RING,   # Protects

    _MAX,
}

enum Elements {
    FIRE,
    WATER,
    WIND,
    ROCK,
    MAGIC

    _MAX
}

enum Dir {
    LEFT,
    RIGHT,
    UP,
    DOWN
}

enum Slots {
    HAT,
    RING1,
    RING2,
    WEAPON,

    _MAX
}

enum ActionMode {
    ACTIVE,
    PASSIVE,

    _MAX
}

enum Action {
    RESIST,
    MULTIPLIER,
    HIT,
    PROJECT,
    EXPLODE,
    PROJECT_EXPLODE,

    _MAX
}

enum Team {
    PLAYER,
    ENEMY,

    _MAX
}

enum Tiles {
    Wall1,
    Wall2,
    Wall3,
    Wall4,
    Wall5,
    Wall6,
    Wall7,
    Wall8,
    Wall9,
    Wall10,
    Wall11,
    Wall12,
    Wall13,
    Wall14,
    Wall15,
    Floor1,
    Door1,
    Door2,
    Wall16,
    Wall17,
    Wall18,
    Wall19,
    Wall20,

    _MAX
}

const TileTypes = {
    "Walls": [Tiles.Wall1, Tiles.Wall2, Tiles.Wall3, Tiles.Wall4, Tiles.Wall5, Tiles.Wall6, Tiles.Wall7, Tiles.Wall8,
              Tiles.Wall9, Tiles.Wall10, Tiles.Wall11, Tiles.Wall12, Tiles.Wall13, Tiles.Wall14, Tiles.Wall15, Tiles.Wall16,
              Tiles.Wall17, Tiles.Wall18, Tiles.Wall19, Tiles.Wall20],
    "Doors": [Tiles.Door1, Tiles.Door2],
    "Floors": [Tiles.Floor1],
}

enum TutorialEvents {
    FOCUS_PICKUP,
    ELEMENT_PICKUP,
    FOCUS_EDITOR_OPEN,
}

const ENEMY_IMAGES = {
    "grunt": preload("res://Art/grunt.png"),
    "evil_wizard": preload("res://Art/evil_wizard.png"),
    "fire_elemental": preload("res://Art/fire_elemental.png"),
    "water_elemental": preload("res://Art/water_elemental.png"),
    "elemental_boss": preload("res://Art/elemental_boss.png"),
    "balrog": preload("res://Art/balrog.png"),
}

const ELEMENT_IMAGES = {
    Elements.FIRE: preload("res://Art/elements/fire.png"),
    Elements.WATER: preload("res://Art/elements/water.png"),
    Elements.WIND: preload("res://Art/elements/wind.png"),
    Elements.ROCK: preload("res://Art/elements/rock.png"),
}

const FOCUS_IMAGES = {
    Foci.STICK: preload("res://Art/foci/stick.png"),
    Foci.WAND: preload("res://Art/foci/wand.png"),
    Foci.STAFF: preload("res://Art/foci/staff.png"),
    Foci.HAT: preload("res://Art/foci/hat.png"),
    Foci.RING: preload("res://Art/foci/ring.png"),
}

# Special cased focus images
const ENCHANTED_FOCUS_IMAGES = {
    Foci.STICK: {
        Elements.FIRE: preload("res://Art/foci/torch.png"),
    },
}

const WORLD_ITEM_IMAGES = {
    WorldItem.STICK: preload("res://Art/foci/stick.png"),
    WorldItem.WAND: preload("res://Art/foci/wand.png"),
    WorldItem.STAFF: preload("res://Art/foci/staff.png"),
    WorldItem.HAT: preload("res://Art/foci/hat.png"),
    WorldItem.RING: preload("res://Art/foci/ring.png"),

    WorldItem.FIRE: preload("res://Art/elements/fire.png"),
    WorldItem.WATER: preload("res://Art/elements/water.png"),
    WorldItem.ROCK: preload("res://Art/elements/rock.png"),
    WorldItem.WIND: preload("res://Art/elements/wind.png"),

    # WorldItem.HEALTH,
    # WorldItem.SPEED,
}

const PROJECTILE_IMAGES = {
    Elements.FIRE: preload("res://Art/projectiles/fireball.png"),
    Elements.WATER: preload("res://Art/projectiles/waterball.png"),
    Elements.ROCK: preload("res://Art/projectiles/rockball.png"),
    Elements.WIND: preload("res://Art/projectiles/windball.png"),
    Elements.MAGIC: preload("res://Art/projectiles/magicball.png"),
}

# Names of unenchanted foci
const FOCUS_NAMES = {
    Foci.STICK: "Stick",
    Foci.WAND: "Short pointy stick",
    Foci.STAFF: "Long rugged stick",
    Foci.HAT: "Floppy hat",
    Foci.RING: "Gaudy ring",
}

const FOCUS_FLAVOUR = {
    Foci.STICK: "Useful for hitting things",
    Foci.WAND: "Useful for poking things",
    Foci.STAFF: "Useful for whacking things",
    Foci.HAT: "Very stylish",
    Foci.RING: "Very bling"
}

# Templates for formatting enchanted focus names
const ENCHANTED_FOCUS_NAME_TEMPLATES = {
    Foci.STICK: "Stick of %s",
    Foci.WAND: "Wand of %s projection",
    Foci.STAFF: "Staff of Exploding %s",
    Foci.HAT: "Hat of %s Enhancement",
    Foci.RING: "Ring of %s Protection",
}

const ENCHANTED_FOCUS_FLAVOUR_TEMPLATES = {
    Foci.STICK: "It's got %s on the end",
    Foci.WAND: "Shoots %sbolts with great force",
    Foci.STAFF: "Explodes with blasts of %s",
    Foci.HAT: "You feel %s coursing through your veins",
    Foci.RING: "You feel as if %s couldn't possibly hurt you"
}

# Special cased focus names
const ENCHANTED_FOCUS_NAMES = {
    Foci.STICK: {
        Elements.FIRE: "Torch",
        Elements.WATER: "Wet Stick",
        Elements.ROCK: "Club",
        Elements.WIND: "Flute",
    },
    Foci.HAT: {
        Elements.FIRE: "Hat on fire",
        Elements.WATER: "Healing hat",
    }
}

# Special cased flavour text
const ENCHANTED_FOCUS_FLAVOUR = {}

const ELEMENT_NAMES = {
    Elements.FIRE: "Fire",
    Elements.WATER: "Water",
    Elements.ROCK: "Rock",
    Elements.WIND: "Wind",
    Elements.MAGIC: "Magic",
}

var ai_manager: AIManager = null
var damage_popup_font: DynamicFont = null

const ELEMENT_CANCELLATION = {
    Elements.FIRE: [Elements.WATER],
    Elements.WATER: [Elements.FIRE],
    Elements.ROCK: [Elements.WIND],
    Elements.WIND: [Elements.ROCK],
    Elements.MAGIC: [],
}