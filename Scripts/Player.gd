extends CharacterBody2D

# Movement variables
@export var move_speed: float = 200.0
@export var jump_force: float = 500.0
@export var gravity: float = 1200.0
@export var max_fall_speed: float = 800.0

# Dash variables
@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 1.0

# Advanced jump features
@export var coyote_time: float = 0.2 # Time the player can jump after leaving the ground
@export var jump_buffer_time: float = 0.15 # Time the player can press jump before landing

# Internal variables
var is_jumping: bool = false
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor() and not is_dashing:
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)

	# Coyote time
	if is_on_floor():
		coyote_timer = coyote_time
		is_jumping = false
	else:
		coyote_timer -= delta

	# Jump buffering
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time

	# Execute jump
	if jump_buffer_timer > 0 and coyote_timer > 0 and not is_dashing:
		velocity.y = -jump_force
		is_jumping = true
		jump_buffer_timer = 0.0

	# Variable jump height
	if is_jumping and Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	# Dashing
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0 and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown

	if is_dashing:
		velocity.x = dash_speed * Input.get_axis("left", "right")
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

	# Dash cooldown
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Horizontal movement (normal)
	if not is_dashing:
		var input = Input.get_axis("left", "right")
		velocity.x = input * move_speed

	# Speed boost when holding sprint
	if Input.is_action_pressed("sprint") and not is_dashing:
		velocity.x *= 1.5

	# Move the player
	move_and_slide()
