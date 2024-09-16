extends CharacterBody2D

signal arrived
signal out

const SPEED = 100
const JUMP_VELOCITY = -400.0

var target = position 
var checkposition = false
var direction = "left"
var animationToPlay = "default"
var shownOneTime = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func moveTo(targetPosition):
	target = targetPosition 
	checkposition = true
	velocity = position.direction_to(target) * SPEED

func beuBirra():
	$AnimatedSprite2D.play("birra")
	
func stopBirra():
	$AnimatedSprite2D.stop()	

func _physics_process(delta):
	if checkposition == true:
		$AnimatedSprite2D.play(animationToPlay)
		#velocity = position.direction_to(target) * SPEED
		#move_and_slide()
		if direction == "right":
			if position.y >= 200:
				emit_signal("out")
			if position.x <= target.x:
				emit_signal("arrived")
			else:
				move_and_slide()
		if direction == "left":
			if position.y >= 200:
				emit_signal("out")
			if position.x <= target.x:
				if shownOneTime == true:
					shownOneTime = false
					
				emit_signal("arrived")

			else:
				move_and_slide()

	pass
