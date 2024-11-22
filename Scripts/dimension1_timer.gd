extends Timer

func _on_timeout():
	var player = get_tree().root.get_node("Dimension1/Player")
	GlobalObjects.player_global_position_x = player.global_position.x
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
