extends CharacterBody2D
class_name Bomb_Class

func _ready():
	$AudioStreamPlayer.play_sound("Throw")

## Bounce ##
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider() is Player_Class: return
		velocity = velocity.bounce(collision_info.get_normal())
		if velocity.abs() < Vector2(GameData.max_bomb_speed, GameData.max_bomb_speed):
			velocity *= Vector2(GameData.additive_bomb_speed, GameData.additive_bomb_speed)
		else:
			pass
		$AudioStreamPlayer.play_sound("Bomb_Bounce")
		$AnimationPlayer.play("Hit")

## Collide ##
func _on_area_2d_body_entered(body):
	if body is Player_Class:
		LocalMultiplayer.player_with_bomb = body
		body.holding_bomb = true
		queue_free()
	else:
		pass
