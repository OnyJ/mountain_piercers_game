extends Sprite

export var spit_speed = 1500
export var fire_rate = 0.2

var spit = preload("res://scenes/Spit.tscn") # possible doing const ?
var can_shoot = true

func _process(delta):
	look_at((get_global_mouse_position()))
	
	if Input.is_action_pressed("shoot") and can_shoot:
		var spit_instance = spit.instance()
		spit_instance.position = $ShootingPoint.get_global_position()
		spit_instance.rotation_degrees = rotation_degrees
		spit_instance.apply_impulse(
			Vector2(), 
			Vector2(spit_speed, 0).rotated(rotation)
		)
		get_tree().get_root().add_child(spit_instance)
		can_shoot = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_shoot = true

func _physics_process(delta):
	var direction = Vector2()
