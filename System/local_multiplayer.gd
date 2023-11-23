extends Node2D

##################
#                #
#    Mischal24   #
# Senior Project #
#                #
##################

## Variables ##
@export var player_tscn : PackedScene

var players_joined : Array
var players_joined_scenes : Array

var game_started : bool = false

## Game ##
func _input(event):
	if get_tree().current_scene.name == "MainMenu": return
	if Input.is_action_just_released("KeyAdd"):
		if players_joined.has("key"):
			return
		else:
			var new_player = player_tscn.instantiate()
			players_joined.append("key")
			_add_player(new_player, 0, -1)
	if Input.is_action_just_released("JoyAdd"):
		if players_joined.has("joy" + str(event.device)):
			return
		else:
			var new_player = player_tscn.instantiate()
			players_joined.append("joy" + str(event.device))
			_add_player(new_player, 1, event.device)

	if Input.is_action_just_pressed("test2"):
		clean_game()

func _add_player(player, method, id):
	player.current_input_method = method
	player.controller_id = id
	player.name = str(id)
	players_joined_scenes.append(player)

func begin_game(map):
	for all in players_joined_scenes:
		all.position = Vector2(round(DisplayServer.screen_get_size().x)/2, round(DisplayServer.screen_get_size().y)/2)
		get_tree().current_scene.add_child(all)
	#map.instantiate()
	get_tree().current_scene.add_child(map)
	game_started = true
	spawn_bomb(Vector2.ZERO, Vector2(initial_speed, -initial_speed), true)
	await get_tree().create_timer(1).timeout
	$BombTimer.start()

func clean_game():
	$BombTimer.stop()
	players_joined.clear()
	players_joined_scenes.clear()
	get_tree().reload_current_scene()
	game_started = false

##Bomb##
@export var bomb_tscn : PackedScene

var initial_speed : float = 300
var player_with_bomb : Node

func _on_bomb_timer_timeout():
	if player_with_bomb != null:
		#player_with_bomb.queue_free()
		print(player_with_bomb)
	else:
		pass
	await get_tree().create_timer(1).timeout
	spawn_bomb(Vector2.ZERO, Vector2(initial_speed, -initial_speed), true)
	$BombTimer.start()

func spawn_bomb(spawn_location, velocity, is_spawning):
	if get_tree().current_scene.has_node("Bomb"): return
	if is_spawning:
		if player_with_bomb != null: return
	else:
		pass
	var new_bomb = bomb_tscn.instantiate()
	new_bomb.position = spawn_location
	new_bomb.velocity = velocity
	get_tree().current_scene.add_child(new_bomb)
