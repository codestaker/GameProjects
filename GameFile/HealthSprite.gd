extends Sprite

func _process(delta):
	if Global.David != null:
		frame = Global.David.health
