extends card
func use(PC):
	var direction = -PC.cameraf.get_global_transform().basis.z
	PC.velocity += direction.normalized * 1000
	uses -= 1
	if uses <= 0:
		queue_free()
