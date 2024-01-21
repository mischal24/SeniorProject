extends Node

#region Variables

#This variable is an exception as it needs to be called on this scene
@onready var scene = get_tree().current_scene
#endregion

#region Add and Remove Players
func _input(event):
	if GameData.game_started == true: return

	if Input.is_action_just_released("key_join"):
		add_player(GameData.key_id)
	if Input.is_action_just_released("key_leave"):
		remove_player(GameData.key_id)

	if Input.is_action_just_released("joy_join"):
		add_player(event.device)
	if Input.is_action_just_released("joy_leave"):
		remove_player(event.device)

func add_player(input):
	if GameData.player_list.has(str(input)): return
	var new_player = GameData.player_scene.instantiate()
	GameData.player_list[str(input)] = new_player
 
func remove_player(input):
	GameData.player_list.erase(str(input))
#endregion

#region Game Logic
func _process(delta):
	if Input.is_action_just_pressed("Start"):
		start_game()
	if GameData.player_list.size() < GameData.min_player_count and GameData.game_started:
		restart_game()

func start_game():
	if GameData.player_list.size() < GameData.min_player_count: return
	if GameData.player_list.size() > GameData.max_player_count: return
	var new_bomb = GameData.bomb_scene.instantiate()
	new_bomb.global_position = GameData.center
	scene.add_child(new_bomb)
	var new_map = GameData.maps[GameData.selected_map].instantiate()
	scene.get_node("CanvasLayer/Timer").show()
	scene.get_node("CanvasLayer/Level Select").hide_scene()
	scene.add_child(new_map)
	for i in GameData.player_list:
		var added_player = GameData.player_list[i]
		
		if is_instance_valid(added_player):
			added_player.current_method = str_to_var(i)
			added_player.global_position = GameData.center + Vector2(0, 200)

			scene.add_child(added_player)
		else:
			print("invald instance")
	for i in scene.get_children():
		scene.get_node("Camera").add_target(i)
	GameData.game_started = true
	await get_tree().create_timer(5).timeout
	scene.get_node("CanvasLayer/Timer").hide()

func restart_game():
	scene.get_node("CanvasLayer/Level Select").show_scene()
	await get_tree().create_timer(1).timeout
	scene.get_node("CanvasLayer/Timer").hide()
	GameData.player_list.clear()
	for i in scene.get_children():
		if i is Player_Class:
			i.queue_free()
		if i is Bomb_Class:
			i.queue_free()
		if i.is_in_group("Maps"):
			i.queue_free()
	GameData.game_started = false
#endregion
