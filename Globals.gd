extends Node

# You can find these in the world
enum WorldItem {
    HAT,
    TORCH,

    _MAX,
}

enum Foci {
    STICK,  # Hits things (Element slot)
    WAND,   # Shoots things (Element slot)
    STAFF,  # Explodes (Element slot)
    HAT,    # Enhances constitution (Constitution slot)
    RING,   # Protects (Element slot)

    _MAX,
}

enum Elements {
    FIRE,
    WATER,
    WIND,
    ROCK,

    _MAX
}

enum Constitution {
    HEALTH,
    SPEED,

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
