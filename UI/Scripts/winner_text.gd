extends Control

@export var messages : Array[String]

func set_up():
	$Label.hide()
	randomize()
	$Label.text = messages.pick_random()

func display_winner(color):
	if color != null:
		modulate = color
	$AnimationPlayer.play("popup")
	await $AnimationPlayer.animation_finished
