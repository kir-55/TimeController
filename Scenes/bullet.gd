extends Area2D

@export var speed: float = 600.0        # Bullet movement speed
var velocity: Vector2 = Vector2.ZERO   # Bullet velocity

func _process(delta: float) -> void:
	# Move the bullet based on velocity
	position += velocity * delta

func set_velocity(direction: Vector2) -> void:
	# Set the bullet's velocity in a specific direction
	velocity = direction.normalized() * speed

func _on_body_entered(body: Node) -> void:
	# Handle collisions with other objects
	queue_free()  # Destroy the bullet upon collision
	
	# Optional: Damage the object if it has a "take_damage" method
	if body.has_method("take_damage"):
		body.take_damage(10)  # Example: Apply 10 damage

func _on_timer_timeout():
	# Destroy the bullet after the timer expires
	queue_free()
