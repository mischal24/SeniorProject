extends Control
## UI

#region Variables
var transitioning_to_game : bool = false
var transitioning_to_settings : bool = false
#endregion

#region Initialization
func _ready():
	$AnimationPlayer.set_current_animation("FromTitle")
	$AnimationPlayer.stop()
	$AnimationPlayer.play()
	$PromoPopup.hide()
	$QuitPopup.hide()
#endregion

#region Events
func _on_play_pressed():
	if transitioning_to_game == false:
		transitioning_to_game = true
		$AnimationPlayer.set_current_animation("ToOther")
		$AnimationPlayer.stop()
		$AnimationPlayer.play()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://Game/Nodes/Scenes/game_scene.tscn")

func _on_settings_pressed():
	if transitioning_to_settings == false:
		transitioning_to_settings = true
		$AnimationPlayer.set_current_animation("ToOther")
		$AnimationPlayer.stop()
		$AnimationPlayer.play()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://UI/Scenes/settings.tscn")

func _on_promo_pressed():
	$PromoPopup.show()

func _on_quit_pressed():
	$QuitPopup.show()

func _on_yes_pressed():
	get_tree().quit()

func _on_no_pressed():
	$PromoPopup.hide()
	$QuitPopup.hide()

func _on_open_pressed():
	OS.shell_open("https://mischal24.itch.io/")
	$PromoPopup.hide()
#endregion
