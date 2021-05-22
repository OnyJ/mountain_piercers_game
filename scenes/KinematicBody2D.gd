extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 120
const SPEED = 100
const JUMP_HEIGHT = -150
var motion = Vector2()  # can store x and y value

func _physics_process(delta):
	motion.y += GRAVITY	
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x= -SPEED
	else:
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	
	motion = move_and_slide(motion, UP)  # UP to show which direction is up
	pass
