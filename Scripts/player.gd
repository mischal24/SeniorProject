extends CharacterBody2D
class_name Player_Class

##Controls##
enum input_methods {keyboard, controller}
var current_input_method : int
#-1 is undefined
var controller_id : int

##Variables##
@export var speed : float = 200.0

@export_group("Jumping")
@export var jump_height : float
@export var jump_time_till_peak : float
@export var jump_time_till_fall : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_till_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_till_peak * jump_time_till_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_till_fall * jump_time_till_fall)) * -1.0

var flipped : bool = false
var holding_bomb : bool = false

## Movement and Gravity ##
func _process(_delta):
	match current_input_method:
		input_methods.keyboard:
			velocity.x = lerp(velocity.x, (Input.get_action_strength("right") - Input.get_action_strength("left")) * speed, 0.1)
			if Input.is_action_pressed("jump") and is_on_floor():
				jump()
			if Input.is_action_just_pressed("throw"):
				throw_bomb(position.direction_to(get_global_mouse_position()))
		input_methods.controller:
			velocity.x = lerp(velocity.x, Input.get_joy_axis(controller_id, JOY_AXIS_LEFT_X) * speed, 0.1)
			if Input.is_joy_button_pressed(controller_id, JOY_BUTTON_A) and is_on_floor():
				jump()
			if Input.get_joy_axis(controller_id, JOY_AXIS_TRIGGER_LEFT) > 0 or Input.get_joy_axis(controller_id, JOY_AXIS_TRIGGER_RIGHT) > 0:
				throw_bomb(Vector2(
					Input.get_joy_axis(controller_id, JOY_AXIS_RIGHT_X),
					Input.get_joy_axis(controller_id, JOY_AXIS_RIGHT_Y)
				))

	if velocity.x < 0 and flipped:
		flip()
	elif velocity.x > 0 and not flipped:
		flip()

	if LocalMultiplayer.player_with_bomb == self and holding_bomb:
		$AnimationPlayer.play_animation(1)
	else:
		$AnimationPlayer.play_animation(0)

func flip():
	flipped = !flipped
	$Sprite2D.flip_h = flipped 

func jump():
	velocity.y = jump_velocity

func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _physics_process(delta):
	velocity.y += gravity() * delta
	move_and_slide()

func throw_bomb(throw_rotation):
	if LocalMultiplayer.player_with_bomb == self and throw_rotation != Vector2.ZERO:
		var throw_position = global_position + (throw_rotation * 85)
		LocalMultiplayer.spawn_bomb(throw_position, (throw_rotation * (GameData.initial_bomb_speed * 2)), false)
		holding_bomb = false
	else:
		pass
