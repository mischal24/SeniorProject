extends Node2D

##################
#                #
#    Mischal24   #
# Senior Project #
#                #
##################

## Variables ##
var players_joined : Array
var players_joined_scenes : Array

var game_started : bool = false

## Game ##
func _input(event):
	if game_started : return
	if Input.is_action_just_released("KeyAdd"):
		if players_joined.has("key"):
			return
		else:
			var new_player = load(GameData.player_tscn).instantiate()
			players_joined.append("key")
			_add_player(new_player, 0, -1)
	if Input.is_action_just_released("JoyAdd"):
		if players_joined.has("joy" + str(event.device)):
			return
		else:
			var new_player = load(GameData.player_tscn).instantiate()
			players_joined.append("joy" + str(event.device))
			_add_player(new_player, 1, event.device)

func _process(_delta):
	if game_started and players_joined_scenes.size() <= (GameData.min_player_count-1):
		$BombTimer.stop()
		await get_tree().create_timer(1).timeout
		clean_game()

func _add_player(player, method, id):
	player.current_input_method = method
	player.controller_id = id
	player.name = str(id)
	players_joined_scenes.append(player)

func begin_game(map):
	for all in players_joined_scenes:
		all.position = Vector2.ZERO
		get_tree().current_scene.add_child(all)
	var new_map = map.instantiate()
	get_tree().current_scene.add_child(new_map)
	game_started = true
	await get_tree().create_timer(1).timeout
	spawn_bomb(Vector2.ZERO, Vector2(GameData.initial_bomb_speed, -GameData.initial_bomb_speed), true)
	$BombTimer.start()

func clean_game():
	players_joined.clear()
	players_joined_scenes.clear()
	get_tree().reload_current_scene()
	game_started = false

##Bomb##
var player_with_bomb : Node

func _on_bomb_timer_timeout():
	if player_with_bomb != null:
		player_with_bomb.queue_free()
		players_joined_scenes.erase(player_with_bomb)
	else:
		print("no player with bomb")
	spawn_bomb(Vector2.ZERO, Vector2(GameData.initial_bomb_speed, -GameData.initial_bomb_speed), true)
	$BombTimer.wait_time = randf_range(20.5, 30.5)
	get_tree().current_scene.show_timer()
	$BombTimer.start()

func spawn_bomb(spawn_location, velocity, is_spawning):
	if get_tree().current_scene.has_node("Bomb"): return
	if is_spawning:
		if player_with_bomb != null: return
	else:
		pass
	var new_bomb = load(GameData.bomb_tscn).instantiate()
	new_bomb.position = spawn_location
	new_bomb.velocity = velocity
	get_tree().current_scene.add_child(new_bomb)
	
	new_bomb.get_node("Area2D/CollisionShape2D").disabled = true
	await get_tree().create_timer(0.1).timeout
	if new_bomb != null:
		new_bomb.get_node("Area2D/CollisionShape2D").disabled = false
