extends Timer

@export var sloper: Sloper

func _on_timeout():
	var player = sloper.player
	GlobalObjects.player_global_position_x = sloper.calc_closest_point(player)
	
	get_tree().change_scene_to_file("res://Scenes/dimension_1.tscn")
