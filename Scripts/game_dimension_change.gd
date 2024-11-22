extends Timer

func _on_timeout():
	var player = get_tree().root.get_node("Game/Player")
	GlobalObjects.player_global_position_x = player.global_position.x
	print(GlobalObjects.player_global_position_x)
	get_tree().change_scene_to_file("res://Scenes/dimension_1.tscn")
