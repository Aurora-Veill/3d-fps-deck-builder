extends Node3D

@export var BobCurve: Curve
@export var heldcard = load("res://dash_card.tscn")
var midHeight
var Cycle100 = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = heldcard.instantiate()
	midHeight = position.y
	$Sprite3D.set_texture(temp.sprite)
	$Sprite3D2.set_texture(temp.sprite)

func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.has_method("addCard")):
		body.addCard(heldcard, self)
func _process(delta):
	rotation.y += delta
	Cycle100 += delta * 30
	if Cycle100 > 100:
		Cycle100 = 0.0
	if BobCurve:
		position.y = midHeight + (BobCurve.sample(Cycle100 / 100) * .15)
