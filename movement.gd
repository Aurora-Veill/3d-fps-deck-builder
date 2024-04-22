extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var projectile = preload("res://projectile.tscn")
@onready var cameraf = $fpv
@onready var camera3 = $PivotPoint/tpv
@onready var pivot = $PivotPoint
@onready var rayRizzo = $RayCast3D
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta):
	# Add the gravity.

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("change_camera"):
		if cameraf.is_current():
			camera3.make_current()
		else:
			cameraf.make_current()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	var turn_dir = (int)(Input.is_action_pressed("turn_left")) - (int)(Input.is_action_pressed("turn_right"))
	self.rotate_y(turn_dir * 0.1)
	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		attack(projectile)
func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 100
		if cameraf.is_current():
			cameraf.rotation.x -= event.relative.y / 250
		else:
			pivot.rotation.x -= event.relative.y / 250
			pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-45), deg_to_rad(45))
func attack(projectile: PackedScene) -> void:
	var atk = projectile.instantiate()
	atk.position = global_position
	atk.direction = -cameraf.get_global_transform().basis.z
	get_parent().add_child(atk)
func damage(dmg):
	print("ouch")
