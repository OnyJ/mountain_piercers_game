extends KinematicBody2D

# checkpoint:
# https://www.youtube.com/watch?v=4WywpSBncFI

var is_moving_left = true
var gravity = 10
var velocity = Vector2(0, 0)
var speed = 330  # pixels per seconds ?

func _ready():
	# $AnimationPlayer.play("walk")
	pass

func _process(_delta):
	# if $AnimationPlayer.current_animation == "attack": # stop walking
	# 	return
	move_character()

func move_character():
	if is_moving_left:
		velocity.x = -speed
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP )

func hit():
	$PlayerDetector.monitoring = true
	print("hit")

func end_of_hit():
	$PlayerDetector.monitoring = false
# func start_walk():
# 	$AnimationPlayer.play("move")

func _on_PlayerDetector_body_entered(body):
	# $AnimationPlayer.play("attack")
	hit()
	pass

func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()
