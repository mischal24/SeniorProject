extends AudioStreamPlayer

func play_sound(i):
	stream = GameData.sound_effects[i]
	play()
