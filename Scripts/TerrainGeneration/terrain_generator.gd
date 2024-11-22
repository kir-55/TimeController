extends Node

@export var light_occuluder: LightOccluder2D
@export var ground_line: Line2D
@export var grass_line: Line2D
@export var floor_collider: StaticBody2D

@export var rs: RandomSystem
@export var sloper: Sloper

@export var line_length := 100

# x distance between points
@export var line_segment_length = 96
@export var section_y_change_amplitude = 50

@export var decorations: Array[Decoration]



@export var big_rock: PackedScene

@export var tower_prefab: PackedScene
@export var main_house_prefab: PackedScene

@onready var line_offset = ground_line.width / 2 - 1


func _ready():
	ground_line.global_position.x = -line_length * line_segment_length/2
	ground_line.add_point(Vector2.ZERO)
	
	
	
	for i in range(line_length-1):
		if i % 2 == 1:
			create_next_point(ground_line.get_point_position(i) + Vector2(line_segment_length, rs.get_rnd_float(-section_y_change_amplitude, section_y_change_amplitude)), ground_line.get_point_position(i))
		else:
			create_next_point(ground_line.get_point_position(i) + Vector2(line_segment_length, 0), ground_line.get_point_position(i))
	
	
	
	var points = ground_line.points
		
	#poligon_points.append(points[points.size()-1] - Vector2(0, line_offset - 300))
	#poligon_points.append(points[0] - Vector2(0, line_offset - 300))
	
	#light_occuluder.occluder.polygon = poligon_points
	
	#print("occluder: " + str(light_occuluder.occluder.polygon[1]))
	#sloper.spawn_at_point(big_rock, self, 3, rs.get_rnd_float(0, 1))
	#$sloper.spawn_at_point(big_rock, self, points_amount - 3, rs.get_rnd_float(0, 1))
	
	#sloper.spawn_at_point(main_house_prefab, village, main_house_pos, rs.get_rnd_float(0, 1))

func _process(delta):
	pass
	#if player.global_position.x > ground_line.get_point_position(ground_line.points.size()-1).x - 2000:
		#if ground_line.points.size() % 2 == 1:
			#create_next_point(ground_line.get_point_position(ground_line.points.size()-1) + Vector2(line_section_length, rs.get_rnd_float(-section_y_change_amplitude, section_y_change_amplitude)), ground_line.get_point_position(ground_line.points.size()-1))
		#else:
			#create_next_point(ground_line.get_point_position(ground_line.points.size()-1) + Vector2(line_section_length, 0), ground_line.get_point_position(ground_line.points.size()-1))


func create_next_point(position: Vector2, lastPosition: Vector2):
	var new_shape = CollisionShape2D.new()
	floor_collider.add_child(new_shape)
	var segment = SegmentShape2D.new()
	segment.a = lastPosition - Vector2(0, line_offset)
	segment.b = position - Vector2(0, line_offset)
	new_shape.shape = segment
	ground_line.add_point(position)
	print(position)
	#grass_line.add_point(position)
