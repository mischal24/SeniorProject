extends AudioStreamPlayer2D

@export var sfx : Array[AudioStream]

func play_sfx(i):
	stream = sfx[i]
	play() 
