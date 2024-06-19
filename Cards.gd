extends Control


@onready var PC = get_parent().get_parent().PC
@onready var handC = [$Card0, $Card1, $Card2, $Card3]

func _process(delta):
	if handC:
		for i in handC:
			i.set_texture(null)
			i.get_child(0).set_frame(15)
		for i in range(0, PC.hand.size()):

			if PC.activeCard == i:
				handC[i].position.y = -390
			else:
				handC[i].position.y = -310
			handC[i].set_texture(PC.hand[i].sprite)
			handC[i].get_child(0).set_frame(PC.hand[i].uses - 1)
