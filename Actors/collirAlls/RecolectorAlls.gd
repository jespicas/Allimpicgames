extends AnimatedSprite2D

@export var controls : Resource = null

signal emitButtonWellPressed(position)
signal emitResetWellButtons
signal emitItsOk(position)
signal emitFinish(time)
signal emitEliminaAll(position, name)
signal emitShownAll(position, name)

var pressed = []
var itsOK = false
var numMovements = 0
var currentMovement = []
var movements = []
var currentPosMovement = 0
var timeOK = 0
var sumTimes = 0
var shouldbeCheck = true

var numAllsRecolectats = 0
var namePlayer = "" 
var started = false

var up_Pressed = false
var down_Pressed = false
var left_Pressed = false
var right_Pressed = false
var button_Pressed = false

var isParticipant1 = true

func set_Participant1(is_p1):
	isParticipant1 = is_p1
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".set_animation("default")
#	$".".autoplay = false	
	pass # Replace with function body.

func _process(delta):
	if shouldbeCheck == true:
		timeOK += delta
		checkIsOk()		
	pass
		
func set_start():
	started = true
	
func set_name_player(name):
	namePlayer = name
	
func set_CurrentMovement(current):
	currentMovement = current
func set_Movements(movments):
	movements = movments
	numMovements = movements.size()

func addPressed(action):
	pressed.append(action)
	
func checkIsOk():
	if numAllsRecolectats <= 2:	
		if pressed.size() == 1:
			$".".set_animation("01ajupir")
			$".".play("01ajupir")
		if pressed.size() == 2:
			emit_signal("emitEliminaAll",currentPosMovement, name)
			$".".set_animation("02recollint")
			$".".play("02recollint")
		if pressed.size() == 0:
			emit_signal("emitShownAll", currentPosMovement, name)
			$".".set_animation("default")
			$".".play("default")
		var amountOK = 0
		if namePlayer != "":
			for n in pressed.size():
				if pressed[n] == movements[currentPosMovement][n]:
					amountOK += 1
					emit_signal("emitButtonWellPressed",n)
				else:
					pressed = []
					$".".set_animation("default")
					$".".play("default")
					emit_signal("emitResetWellButtons")
					break
			if amountOK == movements[currentPosMovement].size() and currentPosMovement < 4:
				pressed = []
				itsOK = true
				currentPosMovement += 1
				sumTimes += timeOK
				timeOK = 0
				if numMovements > currentPosMovement:
					numAllsRecolectats += 1
					$".".set_animation("default")
					$".".play("default")	
					emit_signal("emitItsOk", currentPosMovement)

				if numMovements == currentPosMovement:				
					pass
				sumTimes += timeOK
				timeOK = 0
	else:
		pressed = []
		started = false
		emit_signal("emitFinish", sumTimes)

func _input(event):
	if started == true:
		if isParticipant1 == true:
			if Input.is_action_pressed("p1_move_up") and up_Pressed == false:
				up_Pressed = true
			if Input.is_action_just_released("p1_move_up") and up_Pressed == true:
				up_Pressed = false
				pressed.append("up")
			if Input.is_action_pressed("p1_move_down") and down_Pressed == false:
				down_Pressed = true
			if Input.is_action_just_released("p1_move_down") and down_Pressed == true:
				down_Pressed = false
				pressed.append("down")
			if Input.is_action_pressed("p1_move_left") and left_Pressed == false:
				left_Pressed = true
			if Input.is_action_just_released("p1_move_left") and left_Pressed == true:
				left_Pressed = false
				pressed.append("left")
			if Input.is_action_pressed("p1_move_right") and right_Pressed == false:
				right_Pressed = true
			if Input.is_action_just_released("p1_move_right") and right_Pressed == true:
				right_Pressed = false
				pressed.append("right")
			if Input.is_action_pressed("p1_press_button") and button_Pressed == false:
				button_Pressed = true
			if Input.is_action_just_released("p1_press_button") and button_Pressed == true:	
				button_Pressed = false
				pressed.append("button")
		else:
			if Input.is_action_pressed("p2_move_up") and up_Pressed == false:
				up_Pressed = true
			if Input.is_action_just_released("p2_move_up") and up_Pressed == true:
				up_Pressed = false
				pressed.append("up")
			if Input.is_action_pressed("p2_move_down") and down_Pressed == false:
				down_Pressed = true
			if Input.is_action_just_released("p2_move_down") and down_Pressed == true:
				down_Pressed = false
				pressed.append("down")
			if Input.is_action_pressed("p2_move_left") and left_Pressed == false:
				left_Pressed = true
			if Input.is_action_just_released("p2_move_left") and left_Pressed == true:
				left_Pressed = false
				pressed.append("left")
			if Input.is_action_pressed("p2_move_right") and right_Pressed == false:
				right_Pressed = true
			if Input.is_action_just_released("p2_move_right") and right_Pressed == true:
				right_Pressed = false
				pressed.append("right")
			if Input.is_action_pressed("p2_press_button") and button_Pressed == false:
				button_Pressed = true
			if Input.is_action_just_released("p2_press_button") and button_Pressed == true:	
				button_Pressed = false
				pressed.append("button")
			
			
func _on_AnimatedSprite_animation_finished():
	if $".".animation == "01ajupir":
		$".".play("01ajupir")
		$".".frame = 3
	pass # Replace with function body.
