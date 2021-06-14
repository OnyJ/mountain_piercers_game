extends KinematicBody2D

signal health_updated(health)
signal killed()

const UP = Vector2(0, -1)
const GRAVITY = 120
const SPEED = 350
const JUMP_HEIGHT = -150
var motion = Vector2()  # can store x and y value
var state_machine

export (float) var max_health = 100

# onready bcs we don't know export val at start
onready var health = max_health setget _set_health
onready var invulnerability_timer = $InvulnerabilityTimer
onready var effects_animation = $Cart/AnimationPlayer

# func hurt()
	# travel() finds the shortest path btw current node and "hurt" node
# 	state_machine.travel("hurt")

# func die():
# 	state_machine.travel("die")
# 	set_physics_process(false)

func get_input():
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Cart/AnimationPlayer.play("move")
	elif Input.is_action_pressed("ui_left"):
		motion.x= -SPEED
		$Cart/AnimationPlayer.play("move")
	else:
		motion.x = 0
		$Cart/AnimationPlayer.play("idle")
		# if Input.is_action_pressed("shoot"):
		# 	state_machine.travel("shoot")
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT

func _physics_process(_delta):
	get_input()
	motion = move_and_slide(motion, UP)  # UP to show which direction is up
	pass

func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)
		effects_animation.play("damage")

func kill():
	pass

func _set_health(value):
	var prev_health = health
	# health should not be <0 or >max_health (so use clamp)
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")

func _on_InvulnerabilityTimer_timeout():
	effects_animation.play("idle")
