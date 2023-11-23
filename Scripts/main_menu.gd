extends Control

## Setup ##
func _ready():
	for i in GameData.resolutions.size():
		$OptionsPanel/ResolutionButton.add_item(str(GameData.resolutions[i].x)+"x"+str(GameData.resolutions[i].y),i)
		$OptionsPanel/ResolutionButton.selected = GameData.default_resolution
		set_res(GameData.resolutions[GameData.default_resolution])

## Interactions ##
func _on_start_button_pressed():
	get_tree().change_scene_to_file(GameData.game_scene)

func _on_options_button_pressed():
	$MenuPanel.hide()
	$OptionsPanel.show()

func _on_back_button_pressed():
	$MenuPanel.show()
	$OptionsPanel.hide()

#quit
var quit_being_held : bool = false
var seconds_held : float = 0
func _on_quit_button_button_down():
	quit_being_held = true

func _on_quit_button_button_up():
	quit_being_held = false

func _process(delta):
	if quit_being_held == true:
		seconds_held += 1 * delta
	else:
		seconds_held = 0
	if seconds_held > 1:
		get_tree().quit()

#resolution
func set_res(res):
	DisplayServer.window_set_size(res)

func _on_option_button_item_selected(index):
	set_res(GameData.resolutions[index])

#fullscreen
func fullscreen(t):
	if t == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fullscreen_toggle_toggled(button_pressed):
	fullscreen(button_pressed)
