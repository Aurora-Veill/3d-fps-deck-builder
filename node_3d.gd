extends Node3D
var enemy = preload("res://Enemy.tscn")
@onready var spawns = $Spawns.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var enem = enemy.instantiate()
	enem.position = spawns[(randi() % spawns.size())].position
	enem.target = $PC
	add_child(enem)
