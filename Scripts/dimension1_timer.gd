extends Timer

func _on_timeout():
	var player = get_tree().root.get_node("Dimension1/Player")
	#GlobalObjects.player_coords = player.global_position
	#print(GlobalObjects.player_coords)
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
