extends AnimatedSprite

func _on_SpitExplosion_animation_finished():
	queue_free()
