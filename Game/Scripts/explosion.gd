extends GPUParticles2D

func _ready():
	emitting = true
	$SFXPackage.play_sfx(0)
	await get_tree().create_timer(1).timeout
	queue_free()
