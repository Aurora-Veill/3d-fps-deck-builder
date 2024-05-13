extends Node3D

@export var accel = 1.1
@export var lifetime = 120
var dmg = 2
var maker := CharacterBody3D
var pVel = Vector3.ZERO
var velocity
var hasSet = false
var pierce = 2
var hi = 0
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pVel = pVel * accel
	velocity = pVel
	position += velocity
	lifetime -= 1
	if lifetime <= 0:
		queue_free()
	



func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body != maker:
		if body.has_node("HP"):
			print(hi)
			body.get_node("HP").take_dmg(dmg)
			pierce -= 1
			if pierce <= 0:
				print(hi + hi)
				queue_free()
		else:
			queue_free()

func set_dir(dir):
	pVel = dir.normalized() / 1000
