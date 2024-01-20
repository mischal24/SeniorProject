extends Node

func start():
	$AudioStreamPlayer2D.play()

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
