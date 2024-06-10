extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var target := Node3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var hp = 2
var canAttack = true
var projectile = preload("res://projectile.tscn")
@onready var nav = $navigator
@onready var atkCD = $AtkCooldown
signal onDeath(x, y, z)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	var direction = Vector3.ZERO
	move_and_slide()
	if !target:
		return
	if position.distance_to(target.global_position) < 25:
		if position.distance_to(target.global_position) < 10:
			nav.set_target_position(Vector3(randi(), 0, randi()))
		if canAttack:
			atkCD.start()
			attack(projectile)
			canAttack = false
	else:
		nav.set_target_position(target.global_position)
	direction = (nav.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(direction * SPEED, delta)
func attack(projectile: PackedScene) -> void:
		var atk = projectile.instantiate()
		atk.position = position
		atk.set_dir((target.position - position).normalized(), false)
		atk.maker = self
		get_parent().add_child(atk)
		
func _on_hp_on_death():
	onDeath.emit(position.x, position.y, position.z)
	queue_free() # Replace with function body.


func _on_atk_cooldown_timeout():
	canAttack = true # Replace with function body.
