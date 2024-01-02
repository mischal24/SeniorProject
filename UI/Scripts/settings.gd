extends Control
## UI

#region Variables
var transitioning_to_menu : bool = false

var resolutions : Array[Vector2] = [
	Vector2(1280, 720),
	Vector2(1920, 1080)
]
#endregion

#region Initialization
func _ready():
	$AnimationPlayer.set_current_animation("ToMenu")
	$AnimationPlayer.stop()
	for i in resolutions.size():
		$Items/VBoxContainer/ResolutionButton.add_item(str(resolutions[i].x)+"x"+str(resolutions[i].y),i)
		$Items/VBoxContainer/ResolutionButton.selected = GameData.current_resolution
		DisplayServer.window_set_size(resolutions[GameData.current_resolution])
#endregion

#region Events
func _on_display_button_item_selected(index):
	match index:
		0: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_resolution_button_item_selected(index):
	GameData.current_resolution = index
#endregion

#region UI Logic
func _process(delta):
	DisplayServer.window_set_size(resolutions[GameData.current_resolution])
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		$Items/VBoxContainer/DisplayButton.selected = 0
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$Items/VBoxContainer/DisplayButton.selected = 1
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		$Items/VBoxContainer/DisplayButton.selected = 2

func _input(event):
	if Input.is_action_just_pressed("Back"):
		if transitioning_to_menu == false:
			transitioning_to_menu = true
			$AnimationPlayer.play()
			await $AnimationPlayer.animation_finished
			get_tree().change_scene_to_file("res://UI/Scenes/main_menu.tscn")
#endregion
