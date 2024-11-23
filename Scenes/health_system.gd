extends Node
@export var max_health: int
var health: int

func _ready():
	health = max_health
	
func take_damage(damage):
	health -= damage
	if health < 0: 
		#death
		pass
	
