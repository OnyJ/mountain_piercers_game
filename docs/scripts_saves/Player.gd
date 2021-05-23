extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 120
const SPEED = 100
const JUMP_HEIGHT = -150
var motion = Vector2()  # can store x and y value
var state_machine

# func _ready():
	# return AnimationStateMachine in AnimationTree
	# state_machine = $AnimationTree.get("parameters/playback")

# func hurt()
	# travel() finds the shortest path btw current node and "hurt" node
# 	state_machine.travel("hurt")

# func die():
# 	state_machine.travel("die")
# 	set_physics_process(false)

func get_input():
	# var current = state_machine.get_current_node()
	$Cart/AnimationPlayer.play("idle")
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		state_machine.travel("move")
	elif Input.is_action_pressed("ui_left"):
		motion.x= -SPEED
	else:
		motion.x = 0
		state_machine.travel("idle")
		if Input.is_action_pressed("shoot"):
			state_machine.travel("shoot")
		# $AnimationPlayer.play("idle")
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT

func _physics_process(_delta):
	get_input()
	motion = move_and_slide(motion, UP)  # UP to show which direction is up
	pass
