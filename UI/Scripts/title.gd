extends Control
## UI

#region Variables
var transitioning : bool = false
#endregion

#region Initialization
func _ready():
	if $AnimationPlayer.current_animation != "ToMainMenu":
		$AnimationPlayer.set_current_animation("Idle")
		$AnimationPlayer.call_deferred("stop")
#endregion

#region UI Logic
func _process(_delta):
	if $AnimationPlayer.current_animation != "ToMainMenu":
		$AnimationPlayer.play()

func _input(_event):
	if Input.is_anything_pressed():
		to_main_menu()
#endregion

#region Custom Functions
func to_main_menu():
	if transitioning == false:
		UISFX.play_sfx(0)
		MUSIC.start()
		$AnimationPlayer.set_current_animation("ToMainMenu")
		$AnimationPlayer.play()
		transitioning = true
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://UI/Scenes/main_menu.tscn")
	else:
		return
#endregion
