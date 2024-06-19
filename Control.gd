extends Control

@export var dmgCurve: Curve
@export var PC: Node
@onready var PCHP = PC.getHPNode()
@onready var blood = $BoxContainer/Blood
# Called when the node enters the scene tree for the first time.
var dmgVal = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (blood):
		blood.self_modulate.a = dmgCurve.sample(1 - float(PCHP.hp)/PCHP.maxHP)
