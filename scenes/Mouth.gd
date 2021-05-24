extends Sprite

# shooter
func _process(delta):
	look_at((get_global_mouse_position()))
# https://www.youtube.com/watch?v=cei9BZMzVLY
