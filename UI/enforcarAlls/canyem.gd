extends Node2D

var yellow = Color(171,128,107)
var red = Color(1,0,0)
var blue = Color(64,61,127)

var originalColor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalColor =  $canyem.modulate
	pass # Replace with function body.

func selectColor(color):
	if color == "yellow":
		$canyem.modulate = yellow
		
	if color == "red":
		pass
	if color == "blue":
		$canyem.modulate = blue
	if color == "default":
		pass
	pass

func changeFlip(value):
	$canyem.flip_h = value

func changeCanyemSolFlip(value):
	$canyemsol.flip_h = value	


func select(flip):
	$torcatNoMa.hide()
	$torcatMa.hide()
	$canyem.show()
	$canyemsol.hide()
	$canyem.flip_h = flip
	$AnimatedSprite2D.hide()

func unselect(flip):
	$torcatNoMa.hide()
	$torcatMa.hide()
	$canyem.hide()
	$canyemsol.show()
	$canyemsol.flip_h = flip
	$AnimatedSprite2D.hide()

func agafa():
	$torcatNoMa.hide()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.animation = "default"
	$canyemsol.hide()
	$canyem.hide()
	$torcatMa.hide()
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.flip_h = $canyem.flip_h
	
func deixa():
	$torcatNoMa.hide()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.animation = "deixar"
	$canyemsol.hide()
	$canyem.hide()
	$torcatMa.hide()
	$AnimatedSprite2D.play()	
	$AnimatedSprite2D.flip_h = $canyem.flip_h
	
func gira():
	$torcatNoMa.hide()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.animation = "gira"
	$canyemsol.hide()
	$canyem.hide()
	$torcatMa.hide()
	$AnimatedSprite2D.play()	
	$AnimatedSprite2D.flip_h = $canyem.flip_h

func deixaTorcat(flip):
	$AnimatedSprite2D.hide()
	$canyemsol.hide()
	$canyem.hide()
	$torcatMa.show()
	$torcatMa.flip_h = flip

func deixaTorcatNoMa(flip):
	$AnimatedSprite2D.hide()
	$canyemsol.hide()
	$canyem.hide()
	$torcatMa.hide()
	$torcatNoMa.show()
	$torcatNoMa.flip_h = flip	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.draw_end_animation()	
	pass # Replace with function body.
