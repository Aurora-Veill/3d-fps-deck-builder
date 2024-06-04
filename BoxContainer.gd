extends BoxContainer


@onready var PC = $"../../PC"
@onready var handC = [$Card0, $Card1, $Card2, $Card3]

func _process(delta):
	if handC:
		for i in handC:
			i.set_texture(null)
		for i in range(0, PC.hand.size()):
			handC[i].set_texture(PC.hand[i].sprite)
