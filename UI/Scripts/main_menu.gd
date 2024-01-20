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
	UISFX.play_sfx(0)
	if transitioning_to_game == false:
		transitioning_to_game = true
		$AnimationPlayer.set_current_animation("ToOther")
		$AnimationPlayer.stop()
		$AnimationPlayer.play()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://Game/Nodes/Scenes/game_scene.tscn")

func _on_settings_pressed():
	UISFX.play_sfx(1)
	if transitioning_to_settings == false:
		transitioning_to_settings = true
		$AnimationPlayer.set_current_animation("ToOther")
		$AnimationPlayer.stop()
		$AnimationPlayer.play()
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://UI/Scenes/settings.tscn")

func _on_promo_pressed():
	UISFX.play_sfx(1)
	$PromoPopup.show()

func _on_quit_pressed():
	UISFX.play_sfx(1)
	$QuitPopup.show()

func _on_yes_pressed():
	UISFX.play_sfx(1)
	get_tree().quit()

func _on_no_pressed():
	UISFX.play_sfx(1)
	$PromoPopup.hide()
	$QuitPopup.hide()

func _on_open_pressed():
	UISFX.play_sfx(1)
	OS.shell_open("https://mischal24.itch.io/")
	$PromoPopup.hide()

func _on_play_mouse_entered():
	UISFX.play_sfx(2)

func _on_settings_mouse_entered():
	UISFX.play_sfx(2)

func _on_promo_mouse_entered():
	UISFX.play_sfx(2)

func _on_quit_mouse_entered():
	UISFX.play_sfx(2)
#endregion
