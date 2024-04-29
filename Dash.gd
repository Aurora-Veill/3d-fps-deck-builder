extends card
var PC
var timer

func use(Player):
	PC = Player
	var direction = -PC.cameraf.get_global_transform().basis.z
	PC.velocity = direction.normalized() * 400
	uses -= 1
	if uses <= 0:
		queue_free()
