extends Node2D

var up_Pressed = false
var down_Pressed = false
var left_Pressed = false
var right_Pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventJoypadMotion or InputEventJoypadButton:
		if Input.is_action_pressed("p1_move_up") and up_Pressed == false:
			up_Pressed = true
		if Input.is_action_just_released("p1_move_up") and up_Pressed == true:
			up_Pressed = false
			print("up")
		if Input.is_action_pressed("p1_move_down") and down_Pressed == false:
			down_Pressed = true
		if Input.is_action_just_released("p1_move_down") and down_Pressed == true:
			down_Pressed = false
			print("down")
		if Input.is_action_pressed("p1_move_left") and left_Pressed == false:
			left_Pressed = true
		if Input.is_action_just_released("p1_move_left") and left_Pressed == true:
			left_Pressed = false
			print("left")
		if Input.is_action_pressed("p1_move_right") and right_Pressed == false:
			right_Pressed = true
		if Input.is_action_just_released("p1_move_right") and right_Pressed == true:
			right_Pressed = false
			print("right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
