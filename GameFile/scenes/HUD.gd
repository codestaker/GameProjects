extends CanvasLayer

var coins = -3
func _ready():
	$Coins.text = String(coins)


func _on_coin_collected():
	coins = coins + 1
	_ready()
	if coins == 10:
		get_tree().change_scene("res://scenes/Play again.tscn")
