extends CharacterBody2D

const SPEED = 350.0
var chase = false
var player_pos = Vector2()

func _physics_process(delta: float) -> void:
	if chase:
		# Calculate the direction towards the player and set the velocity.
		var direction = (player_pos - self.position).normalized()
		velocity = direction * SPEED
		# Face the player while chasing.
		look_at(player_pos)
		move_and_slide()  # Execute the move while handling physics.

	else:
		# If not chasing, set the velocity to zero.
		velocity = Vector2.ZERO
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		chase = true
		player_pos = body.global_position  # Update player position when entering.

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		player_pos = body.global_position
		chase = false
