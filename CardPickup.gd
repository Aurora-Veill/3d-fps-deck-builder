extends Node3D

@export var heldcard = load("res://dash_card.tscn")
@export var sprite = load("res://Screen Overlay Effects/Warbringer.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite3D.set_texture(sprite)
	$Sprite3D2.set_texture(sprite)


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.has_method("addCard")):
		body.addCard(heldcard)
	queue_free()
