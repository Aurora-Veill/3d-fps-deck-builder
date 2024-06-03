extends Node3D

var cards = {
	0: [load("res://dash_card.tscn"), load("res://Screen Overlay Effects/Warbringer.png")],
	1: [load("res://projectile_charge.tscn"), load("res://Image.jpg")]
}
var template = load("res://card_pickup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnUpgrade(x, y, z):
	var cardType = randi_range(0, cards.size() - 1)
	var upgrade = template.instantiate()
	upgrade.heldcard = cards[cardType][0]
	upgrade.sprite = cards[cardType][1]

