extends Node2D

var alls = ["","","","All_4","All_5","All_6","All_7","All_8","All_9","All_10","All_11","All_12","All_13","All_14","All_15","All_16"]
var allsP2 = ["","","","SecondPlayer/All_4","SecondPlayer/All_5","SecondPlayer/All_6","SecondPlayer/All_7","SecondPlayer/All_8","SecondPlayer/All_9","SecondPlayer/All_10","SecondPlayer/All_11","SecondPlayer/All_12","SecondPlayer/All_13","SecondPlayer/All_14","SecondPlayer/All_15","SecondPlayer/All_16"]

var posCanyem1 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(72,106),Vector2(89,106),Vector2(75,106),Vector2(90,125),Vector2(82,135),Vector2(90,145),Vector2(75,155),Vector2(90,165),Vector2(90,180),Vector2(90,190),Vector2(50,190),Vector2(55,200),Vector2(88,200)]
var posCanyem2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(81,106),Vector2(96,115),Vector2(82,115),Vector2(105,125),Vector2(89,135),Vector2(105,145),Vector2(82,155),Vector2(105,165),Vector2(95,180),Vector2(114,190),Vector2(75,190),Vector2(80,200),Vector2(112,200)]
var posCanyem3 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(89,104),Vector2(105,116),Vector2(90,115),Vector2(115,125),Vector2(98,135),Vector2(115,145),Vector2(90,155),Vector2(115,165),Vector2(105,180),Vector2(122,190),Vector2(80,190),Vector2(85,200),Vector2(118,200)]
var posCanyem1Pos1 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(78,96),Vector2(78,106),Vector2(89,115),Vector2(70,120),Vector2(95,125),Vector2(79,135),Vector2(100,145),Vector2(70,155),Vector2(100,165),Vector2(84,180),Vector2(105,190),Vector2(68,190),Vector2(72,200),Vector2(100,200)]
var posCanyem1PosSelect  = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(55,95),Vector2(55,106),Vector2(69,115),Vector2(50,120),Vector2(80,125),Vector2(59,135),Vector2(80,145),Vector2(50,155),Vector2(80,165),Vector2(64,180),Vector2(85,190),Vector2(48,190),Vector2(52,200),Vector2(80,200)]

var posCanyem1P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(242,106),Vector2(259,106),Vector2(245,106),Vector2(260,125),Vector2(252,135),Vector2(260,145),Vector2(245,155),Vector2(260,165),Vector2(260,180),Vector2(260,190),Vector2(220,190),Vector2(225,200),Vector2(258,200)]
var posCanyem2P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(251,106),Vector2(266,115),Vector2(252,115),Vector2(275,125),Vector2(259,135),Vector2(275,145),Vector2(252,155),Vector2(275,165),Vector2(265,180),Vector2(284,190),Vector2(245,190),Vector2(250,200),Vector2(282,200)]
var posCanyem3P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(259,104),Vector2(275,116),Vector2(260,115),Vector2(285,125),Vector2(268,135),Vector2(285,145),Vector2(260,155),Vector2(285,165),Vector2(275,180),Vector2(292,190),Vector2(250,190),Vector2(255,200),Vector2(288,200)]
var posCanyem1Pos1P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(248,96),Vector2(248,106),Vector2(259,115),Vector2(240,120),Vector2(265,125),Vector2(249,135),Vector2(270,145),Vector2(240,155),Vector2(270,165),Vector2(254,180),Vector2(275,190),Vector2(238,190),Vector2(242,200),Vector2(270,200)]
var posCanyem1PosSelectP2  = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(225,95),Vector2(225,106),Vector2(239,115),Vector2(220,120),Vector2(250,125),Vector2(229,135),Vector2(250,145),Vector2(220,155),Vector2(250,165),Vector2(234,180),Vector2(255,190),Vector2(218,190),Vector2(222,200),Vector2(250,200)]


var currentPosAlls = 2
var currentPosAllsP2 = 2

var lastPressed = ""
var lastPressedP2 = ""
var currentPosition = "All_1"
var currentPositionP2 = "All_1"

var isCanyemFirstGira = false
var isCanyemSecondGira = false
var isCanyemThirdGira = false

var isCanyemFirstTorcat = false
var isCanyemSecondTorcat = false
var isCanyemThirdTorcat = false

var isCanyemFirstGiraP2 = false
var isCanyemSecondGiraP2 = false
var isCanyemThirdGiraP2 = false


var isCanyemFirstTorcatP2 = false
var isCanyemSecondTorcatP2 = false
var isCanyemThirdTorcatP2 = false


var moviments = [false,false,false]
var movimentsP2 = [false,false,false]

var numAllsEnforcats = 0
var numAllsEnforcatsP2 = 0

var isTorcat = false
var isTorcatP2 = false

var tempsP1 = 0
var tempsP2 = 0
var gameStart = false
var is_Showing_Square = false

var player1End = false
var player2End = false

var gameFinishedTimer = false
func resetSelects():
	isCanyemFirstGira = false
	isCanyemSecondGira = false
	isCanyemThirdGira = false
	isCanyemFirstTorcat = false
	isCanyemSecondTorcat = false
	isCanyemThirdTorcat = false
	moviments[0] = false
	moviments[1] = false
	moviments[2] = false
	if currentPosition == "All_1":
		selecciona("first")
	if currentPosition == "All_2":
		selecciona("second")
	if currentPosition == "All_3":
		selecciona("third")

func resetSelectsP2():
	isCanyemFirstGiraP2 = false
	isCanyemSecondGiraP2 = false
	isCanyemThirdGiraP2 = false
	isCanyemFirstTorcatP2 = false
	isCanyemSecondTorcatP2 = false
	isCanyemThirdTorcatP2 = false
	movimentsP2[0] = false
	movimentsP2[1] = false
	movimentsP2[2] = false
	if currentPositionP2 == "All_1":
		seleccionaP2("first")
	if currentPositionP2 == "All_2":
		seleccionaP2("second")
	if currentPositionP2 == "All_3":
		seleccionaP2("third")	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.setCurrentGame("EnforcarAlls")
	is_Showing_Square = true
	
	$CanyemFirst.position = Vector2(80,95)
	$CanyemSecond.position = Vector2(88,100)
	$CanyemSecond.changeCanyemSolFlip(false)
	$CanyemThird.position= Vector2(98,105)
	$CanyemThird.changeCanyemSolFlip(false)
	selecciona("first")
	
	if Global.numPlayers == 1:
		hide_SecondPlayer()
	$SecondPlayer/CanyemFirst.position = Vector2(250,95)
	$SecondPlayer/CanyemSecond.position = Vector2(258,100)
	$SecondPlayer/CanyemSecond.changeCanyemSolFlip(false)
	$SecondPlayer/CanyemThird.position= Vector2(268,105)
	$SecondPlayer/CanyemThird.changeCanyemSolFlip(false)
	seleccionaP2("first")	
	pass # Replace with function body.

func hide_SecondPlayer():
	$SecondPlayer.hide()
	$faldaDreta.hide()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.numPlayers == 1:
		#gameStart = false
		if player1End == true:
			gameStart = false
			Global.setScore(str(tempsP1).substr(0,5))
			$RetryGame.menuRetry = true
			$RetryGame.show()
			$RetryGame.ShowRetry()		
		pass
	else:
		if player1End == true and player2End == true:
			gameStart = false
			$Hud.show()
			$Hud.hideTiming()
			$Hud.hideMessageP1()
			$Hud.hideMessageP2()
			if tempsP1 > tempsP2:
				Global.setScore(str(tempsP2).substr(0,5))
				$Hud.show_message("P2 guanya")	
			else:
				Global.setScore(str(tempsP1).substr(0,5))
				$Hud.show_message("P1 guanya")
			
			if Global.numPlayers == 2:
				if gameFinishedTimer == false:
					$TimerGotoRecords.start()
					gameFinishedTimer = true
			else:
				$RetryGame.show()
				$RetryGame.ShowRetry()
		
	if gameStart == true:
		tempsP1 += delta
		tempsP2 += delta
	pass

func selecciona(position):
	if position == "first":
		if isCanyemFirstGira == false:
			$CanyemFirst.select(true)
			$CanyemFirst.position = posCanyem1PosSelect[numAllsEnforcats+3]
		if isCanyemThirdGira == false:
			$CanyemThird.unselect(false)
		if isCanyemSecondGira == false:
			$CanyemSecond.unselect(false)
		if isCanyemThirdTorcat == true:
			$CanyemThird.deixaTorcatNoMa(false)
		if isCanyemFirstTorcat == true:
			$CanyemFirst.deixaTorcat(true)
		if isCanyemSecondTorcat == true:
			$CanyemSecond.deixaTorcatNoMa(false)
	if position == "second":
		if isCanyemFirstGira == false:			
			$CanyemFirst.position = posCanyem1Pos1[numAllsEnforcats+3]
			$CanyemFirst.unselect(true)
			$CanyemFirst.changeCanyemSolFlip(true)
		if isCanyemSecondGira == false:	
			$CanyemSecond.select(false)
		if isCanyemThirdGira == false:
			$CanyemThird.unselect(false)
		if isCanyemFirstTorcat == true:
			$CanyemFirst.deixaTorcatNoMa(true)
		if isCanyemThirdTorcat == true:
			$CanyemThird.deixaTorcatNoMa(false)
		if isCanyemSecondTorcat == true:
			$CanyemSecond.deixaTorcat(false)
		
	if position == "third":
		if isCanyemFirstGira == false:	
			$CanyemFirst.unselect(true)
			$CanyemFirst.position = posCanyem1Pos1[numAllsEnforcats+3] 
		if isCanyemSecondGira == false:	
			$CanyemSecond.unselect(false)
		if isCanyemThirdGira == false:
			$CanyemThird.select(false)
		if isCanyemThirdTorcat == true:
			$CanyemThird.deixaTorcat(false)
		if isCanyemFirstTorcat == true:
			$CanyemFirst.deixaTorcatNoMa(true)
		if isCanyemSecondTorcat == true:
			$CanyemSecond.deixaTorcatNoMa(false)
			
func seleccionaP2(position):
	if position == "first":
		if isCanyemFirstGiraP2 == false:
			$SecondPlayer/CanyemFirst.select(true)
			$SecondPlayer/CanyemFirst.position = posCanyem1PosSelectP2[numAllsEnforcatsP2+3]
		if isCanyemThirdGiraP2 == false:
			$SecondPlayer/CanyemThird.unselect(false)
		if isCanyemSecondGiraP2 == false:
			$SecondPlayer/CanyemSecond.unselect(false)
		if isCanyemThirdTorcatP2 == true:
			$SecondPlayer/CanyemThird.deixaTorcatNoMa(false)
		if isCanyemFirstTorcatP2 == true:
			$SecondPlayer/CanyemFirst.deixaTorcat(true)
		if isCanyemSecondTorcatP2 == true:
			$SecondPlayer/CanyemSecond.deixaTorcatNoMa(false)
	if position == "second":
		if isCanyemFirstGiraP2 == false:			
			$SecondPlayer/CanyemFirst.position = posCanyem1Pos1P2[numAllsEnforcatsP2+3]
			$SecondPlayer/CanyemFirst.unselect(true)
			$SecondPlayer/CanyemFirst.changeCanyemSolFlip(true)
		if isCanyemSecondGiraP2 == false:	
			$SecondPlayer/CanyemSecond.select(false)
		if isCanyemThirdGiraP2 == false:
			$SecondPlayer/CanyemThird.unselect(false)
		if isCanyemFirstTorcatP2 == true:
			$SecondPlayer/CanyemFirst.deixaTorcatNoMa(true)
		if isCanyemThirdTorcatP2 == true:
			$SecondPlayer/CanyemThird.deixaTorcatNoMa(false)
		if isCanyemSecondTorcatP2 == true:
			$SecondPlayer/CanyemSecond.deixaTorcat(false)
		
	if position == "third":
		if isCanyemFirstGiraP2 == false:
			$SecondPlayer/CanyemFirst.unselect(true)
			$SecondPlayer/CanyemFirst.position = posCanyem1Pos1P2[numAllsEnforcatsP2+3]
		if isCanyemSecondGiraP2 == false:	
			$SecondPlayer/CanyemSecond.unselect(false)
		if isCanyemThirdGiraP2 == false:
			$SecondPlayer/CanyemThird.select(false)
		if isCanyemThirdTorcatP2 == true:
			$SecondPlayer/CanyemThird.deixaTorcat(false)
		if isCanyemFirstTorcatP2 == true:
			$SecondPlayer/CanyemFirst.deixaTorcatNoMa(true)
		if isCanyemSecondTorcatP2 == true:
			$SecondPlayer/CanyemSecond.deixaTorcatNoMa(false)
			
func _input(event):
	if Input.is_action_pressed("exit"):
		Global.goto_Jocs()
	
	if is_Showing_Square == true:
		if Input.is_action_pressed("p1_press_button") or  Input.is_action_pressed("p2_press_button") :
			$Info/WaitReadytoHide.start()
	else:
		if Input.is_action_pressed("p2_press_button"):
			if currentPositionP2 == "All_1":
				$SecondPlayer/CanyemFirst.agafa()
			if currentPositionP2 == "All_2":
				$SecondPlayer/CanyemSecond.agafa()
			if currentPositionP2 == "All_3":
				$SecondPlayer/CanyemThird.agafa()
		if Input.is_action_pressed("p1_press_button"):
			if currentPosition == "All_1":
				$CanyemFirst.agafa()
			if currentPosition == "All_2":
				$CanyemSecond.agafa()
			if currentPosition == "All_3":
				$CanyemThird.agafa()
		if Input.is_action_just_released("p1_press_button"):
			isTorcat = false
			if currentPosition == "All_1":
				if isCanyemFirstGira == true:
					$CanyemFirst.deixaTorcat(true)
					isCanyemFirstTorcat = true
				else:
					$CanyemFirst.deixa()
			if currentPosition == "All_2":
				if isCanyemSecondGira == true:
					$CanyemSecond.deixaTorcat(false)
					isCanyemSecondTorcat = true
				else:
					$CanyemSecond.deixa()
			if currentPosition == "All_3":
				if isCanyemThirdGira == true:
					$CanyemThird.deixaTorcat(false)
					isCanyemThirdTorcat = true
				else:
					$CanyemThird.deixa()
		if Input.is_action_just_released("p2_press_button"):
			isTorcatP2 = false
			if currentPositionP2 == "All_1":
				if isCanyemFirstGiraP2 == true:
					$SecondPlayer/CanyemFirst.deixaTorcat(true)
					isCanyemFirstTorcatP2 = true
				else:
					$SecondPlayer/CanyemFirst.deixa()
			if currentPositionP2 == "All_2":
				if isCanyemSecondGiraP2 == true:
					$SecondPlayer/CanyemSecond.deixaTorcat(false)
					isCanyemSecondTorcatP2 = true
				else:
					$SecondPlayer/CanyemSecond.deixa()
			if currentPositionP2 == "All_3":
				if isCanyemThirdGiraP2 == true:
					$SecondPlayer/CanyemThird.deixaTorcat(false)
					isCanyemThirdTorcatP2 = true
				else:
					$SecondPlayer/CanyemThird.deixa()				
		if Input.is_action_pressed("p1_move_up"):
			isTorcat = false		
			if currentPosition == "All_1":
				$CanyemFirst.unselect(false)
				isCanyemFirstGira = false
				isCanyemFirstTorcat = false
				$CanyemFirst.position =  posCanyem1Pos1[numAllsEnforcats+3]
				selecciona("first")
				moviments[0] = false 
			if currentPosition == "All_2":
				$CanyemSecond.unselect(false)
				isCanyemSecondGira = false
				isCanyemSecondTorcat = false
				selecciona("second")
				moviments[1] = false
			if currentPosition == "All_3":
				$CanyemThird.unselect(false)
				isCanyemThirdGira = false
				isCanyemThirdTorcat = false
				selecciona("third")
				moviments[2] = false
			pass
		if Input.is_action_pressed("p2_move_up"):
			isTorcatP2 = false		
			if currentPositionP2 == "All_1":
				$SecondPlayer/CanyemFirst.unselect(false)
				isCanyemFirstGiraP2 = false
				isCanyemFirstTorcatP2 = false
				$SecondPlayer/CanyemFirst.position =  posCanyem1Pos1P2[numAllsEnforcatsP2+3]
				seleccionaP2("first")
				movimentsP2[0] = false 
			if currentPositionP2 == "All_2":
				$SecondPlayer/CanyemSecond.unselect(false)
				isCanyemSecondGiraP2 = false
				isCanyemSecondTorcatP2 = false
				seleccionaP2("second")
				movimentsP2[1] = false
			if currentPositionP2 == "All_3":
				$SecondPlayer/CanyemThird.unselect(false)
				isCanyemThirdGiraP2 = false
				isCanyemThirdTorcatP2 = false
				seleccionaP2("third")
				movimentsP2[2] = false
			pass		
		if Input.is_action_pressed("p1_press_buton2"):
			isTorcat = true
			if currentPosition == "All_1":
				$CanyemFirst.gira()
				isCanyemFirstGira = true
				moviments[0] = true
			if currentPosition == "All_2":
				$CanyemSecond.gira()
				isCanyemSecondGira = true
				moviments[1] = true
			if currentPosition == "All_3":
				$CanyemThird.gira()
				isCanyemThirdGira = true
				moviments[2] = true
		if Input.is_action_pressed("p2_press_buton2"):
			isTorcatP2 = true
			if currentPositionP2 == "All_1":
				$SecondPlayer/CanyemFirst.gira()
				isCanyemFirstGiraP2 = true
				movimentsP2[0] = true
			if currentPositionP2 == "All_2":
				$SecondPlayer/CanyemSecond.gira()
				isCanyemSecondGiraP2 = true
				movimentsP2[1] = true
			if currentPositionP2 == "All_3":
				$SecondPlayer/CanyemThird.gira()
				isCanyemThirdGiraP2 = true
				movimentsP2[2] = true
		if Input.is_action_pressed("p1_move_left"):
			if isTorcat == false :
				lastPressed = "left"
				$AllsInicials.show()
				if currentPosition == "All_1":
					selecciona("third")
					currentPosition = "All_3"
				elif currentPosition == "All_2":
					selecciona("first")
					currentPosition = "All_1"
				elif currentPosition == "All_3":
					selecciona("second")
					currentPosition = "All_2"	
				
				pass
		if Input.is_action_pressed("p2_move_left"):
			if isTorcatP2 == false :
				lastPressedP2 = "left"
				$SecondPlayer/AllsInicials.show()
				if currentPositionP2 == "All_1":
					seleccionaP2("third")
					currentPositionP2 = "All_3"
				elif currentPositionP2 == "All_2":
					seleccionaP2("first")
					currentPositionP2 = "All_1"
				elif currentPositionP2 == "All_3":
					seleccionaP2("second")
					currentPositionP2 = "All_2"	
				
				pass			
		if Input.is_action_pressed("p1_move_right"):
			if isTorcat == false:
				lastPressed = "right"
				if currentPosition == "All_1":
					selecciona("second")
					currentPosition = "All_2"
				elif currentPosition == "All_2":
				#	pass
					selecciona("third")
					currentPosition = "All_3"
				elif currentPosition == "All_3":
					selecciona("first")			
					currentPosition = "All_1"		
				pass
		if Input.is_action_pressed("p2_move_right"):
			if isTorcatP2 == false:
				lastPressedP2 = "right"
				if currentPositionP2 == "All_1":
					seleccionaP2("second")
					currentPositionP2 = "All_2"
				elif currentPositionP2 == "All_2":
				#	pass
					seleccionaP2("third")
					currentPositionP2 = "All_3"
				elif currentPositionP2 == "All_3":
					seleccionaP2("first")			
					currentPositionP2 = "All_1"		
				pass			
		if Input.is_action_pressed("p1_move_down"):
			if moviments[0] == true and moviments[2] == true and moviments[1] == false:
				numAllsEnforcats += 1
				if numAllsEnforcats <= 13:
					var next = currentPosAlls+1
					
					if alls.size() > next:
						var objectToShow = get_node(alls[currentPosAlls+1])
						objectToShow.show()
						$CanyemFirst.position = posCanyem1[currentPosAlls+1]
						$CanyemFirst.unselect(true)
						$CanyemSecond.position = posCanyem2[currentPosAlls+1]
						$CanyemSecond.unselect(false)
						$CanyemThird.position = posCanyem3[currentPosAlls+1]
						$CanyemThird.unselect(false)
						currentPosAlls += 1
					resetSelects()
				else:
					$CanyemFirst.hide()
					$CanyemSecond.hide()
					$CanyemThird.hide()
					$fiAll.show()
					player1End = true
					var temps = tempsP1
					$InfoPlayer1.show()
					$InfoPlayer1/Label.text =" Has acabat"
					$InfoPlayer1/Label2.text =" amb un  "
					$InfoPlayer1/Label3.text =" Temps de:"+(str(int(temps)))
			
			pass
		if Input.is_action_pressed("p2_move_down"):
			if movimentsP2[0] == true and movimentsP2[2] == true and movimentsP2[1] == false:
				numAllsEnforcatsP2 += 1
				var obj = get_node(allsP2[3])
				if numAllsEnforcatsP2 <= 13:
					var next = currentPosAllsP2+1
					if allsP2.size() > next:
						var objectToShow = get_node(allsP2[currentPosAllsP2+1])
						objectToShow.show()
						$SecondPlayer/CanyemFirst.position = posCanyem1P2[currentPosAllsP2+1]
						$SecondPlayer/CanyemFirst.unselect(true)
						$SecondPlayer/CanyemSecond.position = posCanyem2P2[currentPosAllsP2+1]
						$SecondPlayer/CanyemSecond.unselect(false)
						$SecondPlayer/CanyemThird.position = posCanyem3P2[currentPosAllsP2+1]
						$SecondPlayer/CanyemThird.unselect(false)
						currentPosAllsP2 += 1
					resetSelectsP2()
				else:
					$SecondPlayer/CanyemFirst.hide()
					$SecondPlayer/CanyemSecond.hide()
					$SecondPlayer/CanyemThird.hide()
					$SecondPlayer/fiAll.show()
					
					player2End = true
					var temps = tempsP2
					$InfoPlayer2.show()
					$InfoPlayer2/Label.text =" Has acabat"
					$InfoPlayer2/Label2.text =" amb un  "
					$InfoPlayer2/Label3.text =" Temps de:"+(str(int(temps)))
		pass
		

func _on_wait_readyto_hide_timeout() -> void:
	is_Showing_Square = false
	$Info.hide()
	gameStart = true
	$Info/WaitReadytoHide.stop()
	pass # Replace with function body.


func _on_timer_goto_records_timeout() -> void:

	if await Global.ShouldAddScore():
		Global.goto_SaveRecords()
	else:
		Global.goto_Jocs()
	pass # Replace with function body.
