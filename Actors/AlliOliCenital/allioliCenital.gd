extends Node2D

signal mou_amunt
signal mou_avall
signal finish_timer
signal animationFinish
signal animationStarted

signal mou_amunt_fer
signal mou_avall_fer
signal mou_esquerra_fer
signal mou_dreta_fer

var dreta = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if(dreta):
		$CharacterBody2D/AnimatedSprite2D.set_animation("adalt_dreta")
	else:
		$CharacterBody2D/AnimatedSprite2D.set_animation("adalt")		
	connect("mou_amunt", Callable(self, "_mou_amunt"))
	connect("mou_avall", Callable(self, "_mou_avall"))	
	connect("mou_amunt_fer", Callable(self, "_mou_amunt_fer"))
	connect("mou_avall_fer", Callable(self, "_mou_avall_fer"))
	connect("mou_esquerra_fer", Callable(self, "_mou_esquerra_fer"))
	connect("mou_dreta_fer", Callable(self, "_mou_dreta_fer"))	
	pass # Replace with function body.

func _mou_amunt_fer():
	$CharacterBody2D/AnimatedSprite2D.set_animation("adaltFer")	
	$CharacterBody2D/AnimatedSprite2D.play()
func _mou_avall_fer():
	$CharacterBody2D/AnimatedSprite2D.set_animation("abaixFer")	
	$CharacterBody2D/AnimatedSprite2D.play()
func _mou_esquerra_fer():
	if (dreta):
		$CharacterBody2D/AnimatedSprite2D.set_animation("dretaFer")
	else:
		$CharacterBody2D/AnimatedSprite2D.set_animation("esquerraFer")	
	$CharacterBody2D/AnimatedSprite2D.play()
func _mou_dreta_fer():
	if (dreta):
		$CharacterBody2D/AnimatedSprite2D.set_animation("esquerraFer")	
	else:
		$CharacterBody2D/AnimatedSprite2D.set_animation("dretaFer")	
		$CharacterBody2D/AnimatedSprite2D.play()

func set_dreta():
	$CharacterBody2D/AnimatedSprite2D.set_flip_h(true)
	dreta = true
	
func _mou_amunt():
	$CharacterBody2D/AnimatedSprite2D.set_animation("adalt")
	$CharacterBody2D/AnimatedSprite2D.play()
func _mou_avall():
	$Timer.start()
	$CharacterBody2D/AnimatedSprite2D.set_animation("abaix")
	$CharacterBody2D/AnimatedSprite2D.play()
	emit_signal("animationStarted")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	emit_signal("finish_timer")
	$Timer.stop()
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if $CharacterBody2D/AnimatedSprite2D.animation == "abaix":
		emit_signal("animationFinish")
	pass # Replace with function body.
