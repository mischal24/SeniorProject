extends Control
## UI

#region Variables
var p1_joined : bool = false
var p2_joined : bool = false
var p3_joined : bool = false
var p4_joined : bool = false
#endregion

#region Initialization
func _ready():
	$AnimationPlayer.set_current_animation("FromMainMenu")
	$AnimationPlayer.stop()
	$AnimationPlayer.play()
	$PlayerPanels/P1Panel/AnimationPlayer.play("drop")
	$PlayerPanels/P1Panel/AnimationPlayer.stop()
	$PlayerPanels/P2Panel/AnimationPlayer.play("drop")
	$PlayerPanels/P2Panel/AnimationPlayer.stop()
	$PlayerPanels/P3Panel/AnimationPlayer.play("drop")
	$PlayerPanels/P3Panel/AnimationPlayer.stop()
	$PlayerPanels/P4Panel/AnimationPlayer.play("drop")
	$PlayerPanels/P4Panel/AnimationPlayer.stop()
#endregion

#region Custom Functions
func _on_next_pressed():
	UISFX.play_sfx(1)
	GameData.selected_map += 1
	if GameData.selected_map > GameData.maps.size()-1:
		GameData.selected_map = 0
	$Next.release_focus()

func _on_prev_pressed():
	UISFX.play_sfx(1)
	GameData.selected_map -= 1
	if GameData.selected_map < 0:
		GameData.selected_map = GameData.maps.size()-1
	$Prev.release_focus()

func _on_next_mouse_entered():
	UISFX.play_sfx(2)

func _on_prev_mouse_entered():
	UISFX.play_sfx(2)

func hide_scene():
	UISFX.play_sfx(0)
	$AnimationPlayer.play("hide")

func show_scene():
	$Start.hide()
	$PlayerPanels/P1Panel/AnimationPlayer.play("lift")
	p1_joined = false
	$PlayerPanels/P2Panel/AnimationPlayer.play("lift")
	p2_joined = false
	$PlayerPanels/P3Panel/AnimationPlayer.play("lift")
	p3_joined = false
	$PlayerPanels/P4Panel/AnimationPlayer.play("lift")
	p4_joined = false
	$AnimationPlayer.play("show")
#endregion

#region UI Logic
var hold_time : float = 0
func _process(delta):
	if GameData.selected_map < GameData.maps_images.size():
		$Image.texture = GameData.maps_images[GameData.selected_map]

	if Input.is_action_pressed("Back") and not GameData.game_started:
		hold_time += 1 * delta
	if hold_time > 0.7:
		$AnimationPlayer.play("ToMainMenu")
		await $AnimationPlayer.animation_finished
		get_tree().call_deferred("change_scene_to_file", "res://UI/Scenes/main_menu.tscn")
	else:
		if Input.is_action_just_released("Back"):
			hold_time = 0

	if GameData.player_list.size() >= GameData.min_player_count:
		$Start.show()
	else:
		$Start.hide()
	match GameData.player_list.size():
		0:
			if p1_joined:
				if not GameData.game_started:
					UISFX.play_sfx(2)
				$PlayerPanels/P1Panel/AnimationPlayer.play("lift")
				p1_joined = false
		1:
			if not p1_joined:
				UISFX.play_sfx(1)
				$PlayerPanels/P1Panel/AnimationPlayer.play("drop")
				p1_joined = true
				p2_joined = false
				p3_joined = false
				p4_joined = false
			if p2_joined:
				if not GameData.game_started:
					UISFX.play_sfx(2)
				$PlayerPanels/P2Panel/AnimationPlayer.play("lift")
				p2_joined = false
		2:
			if not p2_joined:
				UISFX.play_sfx(1)
				$PlayerPanels/P2Panel/AnimationPlayer.play("drop")
				p1_joined = true
				p2_joined = true
				p3_joined = false
				p4_joined = false
			if p3_joined:
				if not GameData.game_started:
					UISFX.play_sfx(2)
				$PlayerPanels/P3Panel/AnimationPlayer.play("lift")
				p3_joined = false
		3:
			if not p3_joined:
				UISFX.play_sfx(1)
				$PlayerPanels/P3Panel/AnimationPlayer.play("drop")
				p1_joined = true
				p2_joined = true
				p3_joined = true
				p4_joined = false
			if p4_joined:
				if not GameData.game_started:
					UISFX.play_sfx(2)
				$PlayerPanels/P4Panel/AnimationPlayer.play("lift")
				p4_joined = false
		4:
			if not p4_joined:
				UISFX.play_sfx(1)
				$PlayerPanels/P4Panel/AnimationPlayer.play("drop")
				p1_joined = true
				p2_joined = true
				p3_joined = true
				p4_joined = true
	var panels : Array = [
		$PlayerPanels/P1Panel,
		$PlayerPanels/P2Panel,
		$PlayerPanels/P3Panel,
		$PlayerPanels/P4Panel
	]
	for i in GameData.player_list:
		match i:
			"-1":
				var panel = panels[GameData.player_list.size()-1]
				panel.self_modulate = Color("735DCB")
				panel.get_node("Label").self_modulate = Color("4C389C")
			"0":
				var panel = panels[GameData.player_list.size()-1]
				panel.self_modulate = Color("FF6F9A")
				panel.get_node("Label").self_modulate = Color("682549")
			"1":
				var panel = panels[GameData.player_list.size()-1]
				panel.self_modulate = Color("7CBA7E")
				panel.get_node("Label").self_modulate = Color("4E7859")
			"2":
				var panel = panels[GameData.player_list.size()-1]
				panel.self_modulate = Color("F8DF5C")
				panel.get_node("Label").self_modulate = Color("F8815C")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("idle")
#endregion
