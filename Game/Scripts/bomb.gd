extends CharacterBody2D
class_name Bomb_Class

#region Initial Movement
func _ready():
	var bomb_tex_num = randi_range(1, 10)
	if bomb_tex_num == 2:
		$Sprite2D.texture = load("res://Game/Textures/Potato.png")
	velocity = Vector2(1, -1) * GameData.initial_bomb_speed

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		$SFXPackage.play_sfx(0)
		velocity = velocity.bounce(collision_info.get_normal())
		if collision_info.get_collider() is Player_Class: return
		get_tree().current_scene.get_node("Camera").screen_shake(0.2, 0.8)
		GameData.current_bomb_speed.x = clamp(velocity.x, -GameData.max_bomb_speed, GameData.max_bomb_speed)
		GameData.current_bomb_speed.y = clamp(velocity.y, -GameData.max_bomb_speed, GameData.max_bomb_speed)
		GameData.current_bomb_speed *= Vector2(GameData.additive_bomb_speed, GameData.additive_bomb_speed)
		velocity = GameData.current_bomb_speed
	get_tree().current_scene.get_node("CanvasLayer/Timer").get_node("Label").text = str(round($Timer.time_left))
#endregion

#region Events
func _on_area_2d_body_entered(body):
	if body is Player_Class and get_parent() != body:
		body.get_node("Hand").grab_bomb(self)
	else:
		return

func _on_timer_timeout():
	if GameData.current_bomb_parent != null:
		GameData.current_bomb_parent.explode(self)
		velocity = GameData.bomb_direction()
		await get_tree().create_timer(GameData.bomb_collision_delay).timeout
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		pass
	
	$Timer.wait_time = randi_range(10, 30)
	$Timer.start()
	
	get_tree().current_scene.get_node("CanvasLayer/Timer").show()
	await get_tree().create_timer(5).timeout
	get_tree().current_scene.get_node("CanvasLayer/Timer").hide()
#endregion
