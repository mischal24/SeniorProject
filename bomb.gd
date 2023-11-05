extends CharacterBody2D
class_name Bomb_Class

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		velocity *= Vector2(1.05, 1.05)

func _on_area_2d_body_entered(body):
	if body is Player_Class:
		LocalMultiplayer.player_with_bomb = body
		queue_free()
	else:
		pass
