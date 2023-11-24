extends AnimationPlayer

var animations : Array[String] = [
	"Idle",
	"HoldingBomb"
]

func play_animation(i):
	play(animations[i])
