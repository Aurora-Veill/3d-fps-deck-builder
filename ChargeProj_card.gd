extends card
var proj = preload("res://projectile_charge.tscn")

func use(Player):
	var atk = proj.instantiate()
	atk.position = Player.position
	atk.set_dir(-Player.cameraf.get_global_transform().basis.z, true)
	atk.maker = Player
	Player.get_parent().add_child(atk)
	for i in Player.find_child("SpreadAims").get_children():
		var atk2 = proj.instantiate()
		atk2.position = Player.position
		atk2.set_dir(-Player.cameraf.get_global_transform().basis.z, true)
		atk2.pVel.y += (randf_range(0.01, 2) * i.position.y)/250
		atk2.pVel.z += (randf_range(0.01, 2) * i.position.z)/250
		atk2.maker = Player
		Player.get_parent().add_child(atk2)
	uses -= 1
	if uses <= 0:
		Player.removeCard()
		queue_free()
