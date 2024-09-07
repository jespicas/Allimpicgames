extends Node2D

signal mou_amunt
signal mou_avall
signal mou_dreta
signal mou_esquerra

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mou_amunt", Callable(self, "_mou_amunt"))
	connect("mou_avall", Callable(self, "_mou_avall"))
	connect("mou_dreta", Callable(self, "_mou_dreta"))
	connect("mou_esquerra", Callable(self, "_mou_esquerra"))
	pass # Replace with function body.

func _mou_amunt():
	$CharacterBody2D/AnimatedSprite2D.set_animation("dalt")
func _mou_avall():
	$CharacterBody2D/AnimatedSprite2D.set_animation("baix")
func _mou_dreta():
	$CharacterBody2D/AnimatedSprite2D.set_animation("dreta")
func _mou_esquerra():
	$CharacterBody2D/AnimatedSprite2D.set_animation("esquerra")			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
