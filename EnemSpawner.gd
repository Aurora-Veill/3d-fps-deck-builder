extends Node3D

var enemy = preload("res://Enemy.tscn")
@onready var spawns = get_node("../Spawns").get_children()
@onready var upgradeSpawner = $"../UpgradeSpawner"
signal enemDeath
var deathsTill = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enem():
	var enem = enemy.instantiate()
	enem.position = spawns[(randi() % spawns.size())].position
	enem.target = $"../PC"
	enem.onDeath.connect(on_enem_death)
	add_child(enem)

func _on_timer_timeout():
	spawn_enem()

func on_enem_death(x, y, z):
	if deathsTill == 0:
		upgradeSpawner.spawnUpgrade(x, y, z)
		deathsTill = 4
	else:
		deathsTill -= 1
	
