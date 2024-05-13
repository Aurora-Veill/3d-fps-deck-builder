extends Node3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / 100
@export var speed = 0.5
var direction = Vector3.ZERO
var velocityY = 0
var dmg = 1
var maker := CharacterBody3D
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocityY -= gravity * delta 
	position += direction * speed * delta * 60
	position.y += velocityY 
	


func _on_area_3d_body_entered(body):
	if body != maker and body.has_node("HP"):
		body.get_node("HP").take_dmg(dmg)
		queue_free()


func _on_area_3d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body != maker:
		queue_free() # Replace with function body.

func set_dir(dir):
	direction = dir
