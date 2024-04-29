extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var projectile = preload("res://projectile.tscn")
var hp = 100
@onready var cameraf = $fpv
@onready var rayRizzo = $RayCast3D
var hand = Array()
var activeCard = 0
func _process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.x /= 2
	velocity.z /= 2
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x += direction.x * SPEED
		velocity.z += direction.z * SPEED
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED)
		velocity.z += move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		attack(projectile)
	
	if Input.is_action_just_pressed("use_card"):
		pass
		hand[activeCard].use()
		
	if Input.is_action_just_pressed("cycle_card_left"):
		activeCard -= 1
		if activeCard == -1:
			activeCard = hand.size() - 1
		
	if Input.is_action_just_pressed("cycle_card_right"):
		activeCard += 1
		if activeCard == hand.size():
			activeCard = 0
func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 100
		cameraf.rotation.x -= event.relative.y / 250
		
func attack(projectile: PackedScene) -> void:
	var atk = projectile.instantiate()
	atk.position = position
	print()
	atk.direction = -cameraf.get_global_transform().basis.z
	atk.maker = self
	get_parent().add_child(atk)
	
func damage(dmg):
	hp -= dmg
