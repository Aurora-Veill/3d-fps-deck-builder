extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 9
signal take_dmg
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var projectile = preload("res://projectile.tscn")
@onready var cameraf = $fpv
var hand = Array()
var activeCard = 0
var hasDashed = false
func _ready():
	hand.append(load("res://dash_card.tscn").instantiate())
func _process(_delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if not is_on_floor():
		if hasDashed:
			velocity.y -= gravity * delta * 3
		velocity.y -= gravity * delta
	else:
		hasDashed = false
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if abs(velocity.x) < SPEED:
			velocity.x = direction.x * SPEED
		if abs(velocity.z) < SPEED:
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		attack(projectile)
	
	if Input.is_action_just_pressed("use_card"):
		if hand.size() <= activeCard:
			return
		if !hand[activeCard]:
			return
		if hand[activeCard].has_method("use"):
			hand[activeCard].use(self)
		
	if Input.is_action_just_pressed("cycle_card_left"):
		activeCard -= 1
		if activeCard == -1:
			activeCard = hand.size() - 1
		
	if Input.is_action_just_pressed("cycle_card_right"):
		activeCard += 1
		if activeCard == hand.size():
			activeCard = 0
	if velocity.y > JUMP_VELOCITY:
		hasDashed = true
	if abs(velocity.x) > SPEED or abs(velocity.z) > SPEED or velocity.y > JUMP_VELOCITY:
		velocity /= 1.1
func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / 100
		cameraf.rotation.x -= event.relative.y / 250
		
func attack(projectile: PackedScene) -> void:
	var atk = projectile.instantiate()
	atk.position = position
	atk.set_dir(-cameraf.get_global_transform().basis.z, true)
	atk.maker = self
	get_parent().add_child(atk)
	

func removeCard():
	hand.remove_at(activeCard)


func _on_hp_on_death():
	get_tree().change_scene_to_file("res://node_3d.tscn")


func _on_hp_take_dmg():
	take_dmg.emit()
