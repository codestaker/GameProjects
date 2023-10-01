extends Button


func _on_PlayAgain_pressed():
	get_tree().change_scene("res://scenes/level 1.tscn")


func _on_Exit_pressed():
	get_tree().quit()
