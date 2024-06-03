extends card
var proj = preload("res://projectile_charge.tscn")

func use(Player):
	Player.attack(proj)
	uses -= 1
	if uses <= 0:
		Player.removeCard()
		queue_free()
