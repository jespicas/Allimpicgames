extends CharacterBody2D

signal animacioxoca
signal fora
signal disparat(hasDiana)
signal entratForat()

const SPEED = 5.0
const JUMP_VELOCITY = -400.0

var positionY
var caure = false
var disparatAll = false
var positionDisp

var haTocatDiana = false

func Disparat(hasDiana):
	#this is the position obredits
	disparatAll = true
	if hasDiana:
		$AnimatedSprite2D.play("default")
		$AnimatedSprite2D.hide()
		emit_signal("entratForat")
	else:
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("xoca")
	
		 
func _ready():
	connect("disparat", Callable(self, "Disparat"))

func _physics_process(delta):
	if caure == true:
		positionY = position.y + SPEED
		position.y = positionY
		move_and_slide()
		if position.y >= 280:
			emit_signal("fora")
			caure = false
	pass

func _on_animated_sprite_2d_animation_finished():
	caure = true
	$AnimatedSprite2D.show()
	emit_signal("animacioxoca")
	pass # Replace with function body.
