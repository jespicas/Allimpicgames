extends Node2D

signal mou
signal animation_finish

var isFlipH = false
var positionX = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	$CharacterBody2D/AnimatedSprite2D.set_flip_h(isFlipH)
	$CharacterBody2D.position.x = positionX
	connect("mou", Callable(self, "_mou"))
	pass # Replace with function body.

func setPosition(pos):
	positionX = pos
	
func setFlip(isFlip):
	isFlipH = isFlip
	
func _mou():
	$CharacterBody2D/AnimatedSprite2D.set_animation("default")
	$CharacterBody2D/AnimatedSprite2D.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animated_sprite_2d_animation_finished():
	$CharacterBody2D/AnimatedSprite2D.set_animation("stop")
	$CharacterBody2D/AnimatedSprite2D.play()
	emit_signal("animation_finish")	
	pass # Replace with function body.
