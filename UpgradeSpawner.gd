extends Node3D

var cards = [load("res://dash_card.tscn"), load("res://charge_proj_card.tscn")]
var template = load("res://card_pickup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnUpgrade(x, y, z):
	var cardType = randi_range(0, cards.size() - 1)
	var upgrade = template.instantiate()
	upgrade.heldcard = cards[cardType]
	upgrade.position = Vector3(x, y + 0.5, z)
	get_parent().add_child(upgrade)

