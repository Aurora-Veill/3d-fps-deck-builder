extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var target := Node3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var hp = 2
var projectile = preload("res://projectile.tscn")
@onready var nav = $navigator
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	var direction = Vector3.ZERO
	nav.set_target_position(target.global_position)
	direction = (nav.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(direction * SPEED, delta)
	move_and_slide()
	if target.position.distance_to(position) < 100:
		attack(projectile)
		
func attack(projectile: PackedScene) -> void:
		var atk = projectile.instantiate()
		atk.position = position
		atk.direction = (target.position - position).normalized()
		atk.maker = self
		get_parent().add_child(atk)
		
func _on_hp_on_death():
	queue_free() # Replace with function body.
