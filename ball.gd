extends CharacterBody2D

# Score tracking
var player1_score: int = 0
var player2_score: int = 0

# Ball movement and game settings
var ball_speed: float = 5.0
var start_direction: int = 2  # 1 = Player 1, 2 = Player 2

func _ready() -> void:
	# Set initial velocity (moving left with slight angle)
	velocity = Vector2(-ball_speed, 20)

func _physics_process(_delta: float) -> void:
	# Move the ball and check for collision
	var collision = move_and_collide(velocity)
	if collision:
		# Bounce off the surface and increase speed
		var normal = collision.get_normal()
		velocity = velocity.bounce(normal)
		ball_speed += 0.5

	# Check if ball passed player 2 (right side)
	if position.x >= 1024:
		player1_score += 1
		print("Player 1 has scored: ", player1_score)
		start_direction = 2
		reset()

	# Check if ball passed player 1 (left side)
	elif position.x <= 0:
		player2_score += 1
		print("Player 2 has scored: ", player2_score)
		start_direction = 1
		reset()

func reset() -> void:
	# Reset ball to center
	position = Vector2(480, 320)

	# Reset both players' vertical positions
	$"../player".position.y = 320
	$"../player2".position.y = 320

	# Reset ball speed
	ball_speed = 5.0

	# Launch the ball in the opposite direction of the scorer
	if start_direction == 1:
		velocity = Vector2(ball_speed, randf_range(-20, 20))
	elif start_direction == 2:
		velocity = Vector2(-ball_speed, randf_range(-20, 20))
