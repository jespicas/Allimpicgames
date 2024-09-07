extends CharacterBody2D

signal arrived

const SPEED = 100
const JUMP_VELOCITY = -400.0

var target = position 
var checkposition = false
var direction = "right"
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func moveTo(targetPosition):
	target = targetPosition 
	checkposition = true

func _physics_process(delta):
	if checkposition == true:
		velocity = position.direction_to(target) * SPEED
		#move_and_slide()
		if direction == "right":
			if position.x >= target.x:
				emit_signal("arrived")
			else:
				#$RichTextLabel.text = str(position.x)				
				move_and_slide()
		if direction == "left":
			if position.x <= target.x:
				emit_signal("arrived")
			else:
				#$RichTextLabel.text = str(position.x)
				move_and_slide()

	pass
