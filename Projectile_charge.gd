extends Node3D

@export var accel = 1.1
@export var lifetime = 120
var direction = Vector3.ZERO
var dmg = 1
var maker := CharacterBody3D
var pVel = Vector3.ZERO
var velocity
var hasSet = false
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !hasSet and direction != Vector3.ZERO:
		pVel = direction.normalized() / 1000
		hasSet = true
		print(direction)
	pVel = pVel * accel
	velocity = direction * pVel
	position += velocity
	lifetime -= 1
	if lifetime <= 0:
		queue_free()
	


func _on_area_3d_body_entered(body):
	if body != maker and body.has_node("HP"):
		body.get_node("HP").take_dmg(dmg)
		queue_free()


func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body != maker:
		queue_free() # Replace with function body.
