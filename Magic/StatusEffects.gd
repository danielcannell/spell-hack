extends Node
class_name StatusEffects

var Actions_ = Actions.new()

func get_resistance(foci: Array) -> Dictionary:
    var resistances: Dictionary = Config.player_resistances.duplicate()

    for f in foci:
        assert f.action().equals(Actions_.ELEM_PROTECT)
        if f.element != null:
            resistances[f.element.type] *= f.power

    return resistances

func get_buffs(foci: Array) -> Dictionary:
    var buffs: Dictionary = Config.player_buffs.duplicate()

    for f in foci:
        assert f.action().equals(Actions_.MULTIPLIER)
        if f.element != null:
            buffs[f.element.type] *= f.power

    return buffs
