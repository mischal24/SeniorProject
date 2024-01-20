extends Node

#region Snap
func _physics_process(_delta):
	for i in get_children():
		if i is Bomb_Class:
			i.global_position = lerp(i.global_position, $Sprite2D.global_position, 0.7)
		else:
			pass
	$Marker.global_position = lerp($Marker.global_position, get_parent().get_node("MarkerPos").global_position, 0.2)
	if has_node("Bomb"):
		$Marker.show()
	else:
		$Marker.hide()
#endregion

#region Custom Functions
func grab_bomb(item):
	item.velocity = Vector2.ZERO
	item.get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
	item.call_deferred("reparent", self)
	GameData.current_bomb_parent = self
	$AnimationPlayer.play("Hold")

func throw_bomb(direction):
	var item
	if has_node("Bomb"):
		item = get_node("Bomb")
	if item != null:
		$AnimationPlayer.play("Thrown")

		item.call_deferred("reparent", get_tree().current_scene)

		item.velocity = (direction * (GameData.initial_bomb_speed * 2))

		await get_tree().create_timer(GameData.bomb_collision_delay).timeout
		item.get_node("Area2D/CollisionShape2D").set_deferred("disabled", false)

func explode(item):
	item.global_position = GameData.center
	item.call_deferred("reparent", get_tree().current_scene)
	var parent = get_parent()
	var expl = GameData.explosion_scene.instantiate()
	expl.global_position = parent.global_position
	get_tree().current_scene.add_child(expl)
	GameData.player_list.erase(str(parent.current_method))
	parent.queue_free()
#endregion
