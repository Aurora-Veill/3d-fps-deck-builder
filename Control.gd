extends Control

@export var dmgCurve: Curve
@onready var PC = get_node("../PC")
@onready var blood = $BoxContainer/Blood
@onready var maxHP = PC.HP.hp
# Called when the node enters the scene tree for the first time.
var dmgVal = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (blood):
		blood.self_modulate.a = dmgCurve.sample(PC.HP.hp/maxHP)
		dmgVal -= 0.1
		if (dmgVal < 0):
			dmgVal = 0

func _on_pc_take_dmg():
	dmgVal += 10
