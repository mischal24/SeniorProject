extends Control

## Variables ##
var menu_scene : String = "res://Scenes/main_menu.tscn"
@export var maps : Array[PackedScene]
var selected_map : PackedScene

## Setup ##
func _ready():
	for i in maps.size():
		$MenuPanel/ChooseMapButton.add_item(maps[i].name, i)
	LocalMultiplayer.players_joined.clear()

## Interactions ##
func _on_option_button_item_selected(index):
	selected_map = maps[index]

func _on_start_button_pressed():
	LocalMultiplayer.begin_game(selected_map)
	$MenuPanel.hide()
	$GamePanel.show()

func _on_back_button_pressed():
	get_tree().change_scene_to_file(menu_scene)

func _process(_delta):
	$MenuPanel/PlayerLabel.text = str(LocalMultiplayer.players_joined)
	$GamePanel/BombTimeLabel.text = str(roundf(LocalMultiplayer.get_node("BombTimer").time_left))
