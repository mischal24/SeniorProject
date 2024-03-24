extends GPUParticles2D

func _ready():
	emitting = true
	$SFXPackage.play_sfx(0)
	get_tree().current_scene.get_node("Camera").screen_shake(2, 80)
	await get_tree().create_timer(1).timeout
	queue_free()
