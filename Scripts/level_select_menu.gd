extends Control

## Variables ##
var selected_map : PackedScene

## Setup ##
func _ready():
	for i in GameData.maps.size():
		$CanvasLayer/MenuPanel/ChooseMapButton.add_item(GameData.maps[i].map_name, i)
	LocalMultiplayer.players_joined.clear()
	selected_map = GameData.maps[0].map_tscn

## Interactions ##
func _on_choose_map_button_item_selected(index):
	selected_map = GameData.maps[index].map_tscn

func _on_start_button_pressed():
	LocalMultiplayer.begin_game(selected_map)
	show_timer()

func show_timer():
	$CanvasLayer/MenuPanel.hide()
	$CanvasLayer/GamePanel.show()
	await get_tree().create_timer(3).timeout
	$CanvasLayer/GamePanel.hide()

func _on_back_button_pressed():
	get_tree().change_scene_to_file(GameData.menu_scene) 

func _process(_delta):
	$CanvasLayer/MenuPanel/PlayerLabel.text = str(LocalMultiplayer.players_joined)
	$CanvasLayer/GamePanel/BombTimeLabel.text = str(roundf(LocalMultiplayer.get_node("BombTimer").time_left))
	if LocalMultiplayer.players_joined_scenes.size() >= 1:
		$CanvasLayer/MenuPanel/StartButton.disabled = false
	else:
		$CanvasLayer/MenuPanel/StartButton.disabled = true
