extends CharacterBody2D
class_name Bomb_Class

## Bounce ##
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		velocity *= Vector2(GameData.additive_bomb_speed, GameData.additive_bomb_speed)

## Collide ##
func _on_area_2d_body_entered(body):
	if body is Player_Class:
		LocalMultiplayer.player_with_bomb = body
		queue_free()
	else:
		pass
