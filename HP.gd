extends Node3D
@export var maxHP = 100
@export var regenSpeed = 0
@export var maxRegenTimer = 1
var hp = maxHP
var regenTimer = maxRegenTimer
signal takeDmg
signal onDeath
signal onHeal
func take_dmg(dmg):
	if hp <= 0:
		return
	hp -= dmg
	takeDmg.emit()
	if hp <= 0:
		onDeath.emit()
func heal(health):
	hp += health
	hp = min(hp, maxHP)
	onHeal.emit()
func _process(delta):
	regenTimer -= delta
	if regenTimer <= 0:
		regenTimer = maxRegenTimer
		heal(regenSpeed)
