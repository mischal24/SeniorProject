extends Node

@export var sfx : Array[AudioStream]

func play_sfx(i):
	$AudioStreamPlayer2D.stream = sfx[i]
	$AudioStreamPlayer2D.play()
