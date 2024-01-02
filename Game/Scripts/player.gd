extends CharacterBody2D
class_name Player_Class

#region Variables

#These variables are an exception as they need to be unique for each player
var is_flipped : bool = false
var current_method : int = 0

func gravity() -> float:
	return GameData.jump_gravity if velocity.y < 0.0 else GameData.fall_gravity
#endregion

#region Initial Movement
func _physics_process(delta):
	velocity.y += gravity() * delta

	if current_method == -1:
		if Input.is_action_just_pressed("key_jump") and is_on_floor():
			jump()
		var direction = Input.get_axis("key_left", "key_right")
		move(direction)

		if Input.is_action_just_pressed("key_throw"):
			$Hand.throw_bomb(global_position.direction_to(get_global_mouse_position()))
	else:
		if Input.is_joy_button_pressed(current_method, JOY_BUTTON_A) and is_on_floor():
			jump()
		var direction = Input.get_joy_axis(current_method, JOY_AXIS_LEFT_X)
		move(direction)

		if Input.get_joy_axis(current_method, JOY_AXIS_TRIGGER_LEFT) > 0 or Input.get_joy_axis(current_method, JOY_AXIS_TRIGGER_RIGHT) > 0:
			$Hand.throw_bomb(Vector2(
					Input.get_joy_axis(current_method, JOY_AXIS_RIGHT_X),
					Input.get_joy_axis(current_method, JOY_AXIS_RIGHT_Y)
				))

	if velocity.x < 0 and is_flipped:
		flip()
	elif velocity.x > 0 and not is_flipped:
		flip()

	move_and_slide()

	$Hand/Sprite2D.global_position = lerp($Hand/Sprite2D.global_position, $HandPos.global_position, 0.1)
#endregion

#region Custom Functions
func jump():
	velocity.y = GameData.jump_velocity

func move(direction):
	if direction:
		velocity.x = lerp(velocity.x, round(direction) * GameData.player_speed, 0.3)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)

func flip():
	is_flipped = !is_flipped
	scale.x = -scale.x
#endregion
