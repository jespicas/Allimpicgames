extends Node2D

var alls = ["","","","All_4","All_5","All_6","All_7","All_8","All_9","All_10","All_11","All_12","All_13","All_14","All_15","All_16"]
var allsP2 = ["","","","SecondPlayer/All_4","SecondPlayer/All_5","SecondPlayer/All_6","SecondPlayer/All_7","SecondPlayer/All_8","SecondPlayer/All_9","SecondPlayer/All_10","SecondPlayer/All_11","SecondPlayer/All_12","SecondPlayer/All_13","SecondPlayer/All_14","SecondPlayer/All_15","SecondPlayer/All_16"]

var posCanyem1 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(72,106),Vector2(89,106),Vector2(75,106),Vector2(90,125),Vector2(82,135),Vector2(90,145),Vector2(75,155),Vector2(90,165),Vector2(90,180),Vector2(90,190),Vector2(50,190),Vector2(55,200),Vector2(88,200)]
var posCanyem2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(81,106),Vector2(96,115),Vector2(82,115),Vector2(105,125),Vector2(89,135),Vector2(105,145),Vector2(82,155),Vector2(105,165),Vector2(95,180),Vector2(114,190),Vector2(75,190),Vector2(80,200),Vector2(112,200)]
var posCanyem3 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(89,104),Vector2(105,116),Vector2(90,115),Vector2(115,125),Vector2(98,135),Vector2(115,145),Vector2(90,155),Vector2(115,165),Vector2(105,180),Vector2(122,190),Vector2(80,190),Vector2(85,200),Vector2(118,200)]
var posCanyem1Pos1 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(78,96),Vector2(78,106),Vector2(89,115),Vector2(70,120),Vector2(95,125),Vector2(79,135),Vector2(100,145),Vector2(70,155),Vector2(100,165),Vector2(84,180),Vector2(105,190),Vector2(68,190),Vector2(72,200),Vector2(100,200)]
var posCanyem1PosSelect  = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(55,95),Vector2(55,106),Vector2(69,115),Vector2(50,120),Vector2(80,125),Vector2(59,135),Vector2(80,145),Vector2(50,155),Vector2(80,165),Vector2(64,180),Vector2(85,190),Vector2(48,190),Vector2(52,200),Vector2(80,200)]

var posCanyem1P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(202,106),Vector2(219,106),Vector2(205,106),Vector2(220,125),Vector2(212,135),Vector2(220,145),Vector2(205,155),Vector2(220,165),Vector2(220,180),Vector2(220,190),Vector2(180,190),Vector2(185,200),Vector2(218,200)]
var posCanyem2P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(211,106),Vector2(226,115),Vector2(212,115),Vector2(235,125),Vector2(219,135),Vector2(235,145),Vector2(212,155),Vector2(235,165),Vector2(225,180),Vector2(244,190),Vector2(205,190),Vector2(210,200),Vector2(242,200)]
var posCanyem3P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(219,104),Vector2(235,116),Vector2(220,115),Vector2(245,125),Vector2(228,135),Vector2(245,145),Vector2(220,155),Vector2(245,165),Vector2(235,180),Vector2(252,190),Vector2(210,190),Vector2(215,200),Vector2(248,200)]
var posCanyem1Pos1P2 = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(208,96),Vector2(208,106),Vector2(219,115),Vector2(200,120),Vector2(225,125),Vector2(209,135),Vector2(230,145),Vector2(200,155),Vector2(2300,165),Vector2(214,180),Vector2(235,190),Vector2(198,190),Vector2(202,200),Vector2(230,200)]
var posCanyem1PosSelectP2  = [Vector2(10,10),Vector2(10,10),Vector2(10,10),Vector2(185,95),Vector2(185,106),Vector2(199,115),Vector2(180,120),Vector2(210,125),Vector2(189,135),Vector2(210,145),Vector2(180,155),Vector2(210,165),Vector2(194,180),Vector2(215,190),Vector2(178,190),Vector2(182,200),Vector2(210,200)]



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
	$CanyemFirst.position = Vector2(80,95)
	$CanyemSecond.position = Vector2(88,100)
	$CanyemSecond.changeCanyemSolFlip(false)
	$CanyemThird.position= Vector2(98,105)
	$CanyemThird.changeCanyemSolFlip(false)
	selecciona("first")
	
	$SecondPlayer/CanyemFirst.position = Vector2(210,95)
	$SecondPlayer/CanyemSecond.position = Vector2(218,100)
	$SecondPlayer/CanyemSecond.changeCanyemSolFlip(false)
	$SecondPlayer/CanyemThird.position= Vector2(228,105)
	$SecondPlayer/CanyemThird.changeCanyemSolFlip(false)
	seleccionaP2("first")	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func selecciona(position):
	if position == "first":
		if isCanyemFirstGira == false:
			$CanyemFirst.select(true)
			$CanyemFirst.position = posCanyem1PosSelect[numAllsEnforcats+3]
			#print("C1 X:"+str(posCanyem1PosSelect[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1PosSelect[numAllsEnforcats+3].y)) #Vector2(55,95)
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
#		print("first")
#		print(isCanyemThirdGira)
	if position == "second":
#		#print("second")
		if isCanyemFirstGira == false:			
			$CanyemFirst.position = posCanyem1Pos1[numAllsEnforcats+3]# Vector2(76,96)
			#print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
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
#		print("third")
		if isCanyemFirstGira == false:	
			$CanyemFirst.unselect(true)
			$CanyemFirst.position = posCanyem1Pos1[numAllsEnforcats+3] #Vector2(76,95)
		#	print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
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
			#print("C1 X:"+str(posCanyem1PosSelect[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1PosSelect[numAllsEnforcats+3].y)) #Vector2(55,95)
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
#		print("first")
#		print(isCanyemThirdGira)
	if position == "second":
#		#print("second")
		if isCanyemFirstGiraP2 == false:			
			$SecondPlayer/CanyemFirst.position = posCanyem1Pos1P2[numAllsEnforcatsP2+3]# Vector2(76,96)
			#print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
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
#		print("third")
		if isCanyemFirstGiraP2 == false:
			$SecondPlayer/CanyemFirst.unselect(true)
			$SecondPlayer/CanyemFirst.position = posCanyem1Pos1P2[numAllsEnforcatsP2+3] #Vector2(76,95)
		#	print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
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
	if Input.is_action_pressed("p2_press_button"):
		if currentPositionP2 == "All_1":
#			print(currentPosition)
			$SecondPlayer/CanyemFirst.agafa()
		if currentPositionP2 == "All_2":
#			print(currentPosition)
			$SecondPlayer/CanyemSecond.agafa()
		if currentPositionP2 == "All_3":
#			print(currentPosition)
			$SecondPlayer/CanyemThird.agafa()
	if Input.is_action_pressed("p1_press_button"):
		if currentPosition == "All_1":
#			print(currentPosition)
			$CanyemFirst.agafa()
		if currentPosition == "All_2":
#			print(currentPosition)
			$CanyemSecond.agafa()
		if currentPosition == "All_3":
#			print(currentPosition)
			$CanyemThird.agafa()
	if Input.is_action_just_released("p1_press_button"):
		isTorcat = false
		if currentPosition == "All_1":
			if isCanyemFirstGira == true:
				$CanyemFirst.deixaTorcat(true)
				isCanyemFirstTorcat = true
			else:
#				print(currentPosition)
				$CanyemFirst.deixa()
		if currentPosition == "All_2":
			if isCanyemSecondGira == true:
				$CanyemSecond.deixaTorcat(false)
				isCanyemSecondTorcat = true
			else:
#				print(currentPosition)
				$CanyemSecond.deixa()
		if currentPosition == "All_3":
			if isCanyemThirdGira == true:
				$CanyemThird.deixaTorcat(false)
				isCanyemThirdTorcat = true
			else:
#				print(currentPosition)
				$CanyemThird.deixa()
	if Input.is_action_just_released("p2_press_button"):
		isTorcatP2 = false
		if currentPositionP2 == "All_1":
			if isCanyemFirstGiraP2 == true:
				$SecondPlayer/CanyemFirst.deixaTorcat(true)
				isCanyemFirstTorcatP2 = true
			else:
#				print(currentPosition)
				$SecondPlayer/CanyemFirst.deixa()
		if currentPositionP2 == "All_2":
			if isCanyemSecondGiraP2 == true:
				$SecondPlayer/CanyemSecond.deixaTorcat(false)
				isCanyemSecondTorcatP2 = true
			else:
#				print(currentPosition)
				$SecondPlayer/CanyemSecond.deixa()
		if currentPositionP2 == "All_3":
			if isCanyemThirdGiraP2 == true:
				$SecondPlayer/CanyemThird.deixaTorcat(false)
				isCanyemThirdTorcatP2 = true
			else:
#				print(currentPosition)
				$SecondPlayer/CanyemThird.deixa()				
	if Input.is_action_pressed("p1_move_up"):
		isTorcat = false		
		if currentPosition == "All_1":
			$CanyemFirst.unselect(false)
			isCanyemFirstGira = false
			isCanyemFirstTorcat = false
			$CanyemFirst.position =  posCanyem1Pos1[numAllsEnforcats+3]# Vector2(76,95)
			print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
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
			$SeconPlayer/CanyemFirst.unselect(false)
			isCanyemFirstGiraP2 = false
			isCanyemFirstTorcatP2 = false
			$SeconPlayer/CanyemFirst.position =  posCanyem1Pos1P2[numAllsEnforcatsP2+3]# Vector2(76,95)
		#	print("C1 X:"+str(posCanyem1Pos1[numAllsEnforcats+3].x)+"Y:"+str(posCanyem1Pos1[numAllsEnforcats+3].y))
			seleccionaP2("first")
			movimentsP2[0] = false 
		if currentPositionP2 == "All_2":
			$SeconPlayer/CanyemSecond.unselect(false)
			isCanyemSecondGiraP2 = false
			isCanyemSecondTorcatP2 = false
			seleccionaP2("second")
			movimentsP2[1] = false
		if currentPositionP2 == "All_3":
			$SeconPlayer/CanyemThird.unselect(false)
			isCanyemThirdGiraP2 = false
			isCanyemThirdTorcatP2 = false
			seleccionaP2("third")
			movimentsP2[2] = false
		pass		
	if Input.is_action_pressed("p1_press_buton2"):
		isTorcat = true # and Input.is_action_pressed("p1_move_right"):
		if currentPosition == "All_1":
			$CanyemFirst.gira()
			isCanyemFirstGira = true
			moviments[0] = true
		#	currentPosition = "All_2"
		if currentPosition == "All_2":
			$CanyemSecond.gira()
			isCanyemSecondGira = true
			moviments[1] = true
		#	currentPosition = "All_3"
		if currentPosition == "All_3":
			$CanyemThird.gira()
			isCanyemThirdGira = true
#			print(isCanyemThirdGira)
			moviments[2] = true
		#	currentPosition = "All_1"	
	if Input.is_action_pressed("p2_press_buton2"):
		isTorcatP2 = true # and Input.is_action_pressed("p1_move_right"):
		if currentPositionP2 == "All_1":
			$SecondPlayer/CanyemFirst.gira()
			isCanyemFirstGiraP2 = true
			movimentsP2[0] = true
		#	currentPosition = "All_2"
		if currentPositionP2 == "All_2":
			$SecondPlayer/CanyemSecond.gira()
			isCanyemSecondGiraP2 = true
			movimentsP2[1] = true
		#	currentPosition = "All_3"
		if currentPositionP2 == "All_3":
			$SecondPlayer/CanyemThird.gira()
			isCanyemThirdGiraP2 = true
#			print(isCanyemThirdGira)
			movimentsP2[2] = true
	if Input.is_action_pressed("p1_move_left"):
		if isTorcat == false :
			lastPressed = "left"
			$AllsInicials.show()
			if currentPosition == "All_1":
				selecciona("third")
		#		print("left")
				currentPosition = "All_3"
			elif currentPosition == "All_2":
				selecciona("first")
		#		print("left")
				currentPosition = "All_1"
			elif currentPosition == "All_3":
				selecciona("second")
		#		print("left")
				currentPosition = "All_2"	
			
			pass
	if Input.is_action_pressed("p2_move_left"):
		if isTorcatP2 == false :
			lastPressedP2 = "left"
			$SecondPlayer/AllsInicials.show()
			if currentPositionP2 == "All_1":
				seleccionaP2("third")
		#		print("left")
				currentPositionP2 = "All_3"
			elif currentPositionP2 == "All_2":
				seleccionaP2("first")
		#		print("left")
				currentPositionP2 = "All_1"
			elif currentPositionP2 == "All_3":
				seleccionaP2("second")
		#		print("left")
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
			print(numAllsEnforcats)
			if numAllsEnforcats <= 13:
				var next = currentPosAlls+1
				#print(str(alls.size()))
				#print(str(next))
				
				if alls.size() > next:
					var objectToShow = get_node(alls[currentPosAlls+1])
					objectToShow.show()
					$CanyemFirst.position = posCanyem1[currentPosAlls+1]
					#print("C1 X:"+str(posCanyem1[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$CanyemFirst.unselect(true)
					$CanyemSecond.position = posCanyem2[currentPosAlls+1]
					#print("C2 X:"+str(posCanyem2[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$CanyemSecond.unselect(false)
					$CanyemThird.position = posCanyem3[currentPosAlls+1]
					#print("C3 X:"+str(posCanyem2[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$CanyemThird.unselect(false)
					currentPosAlls += 1
				resetSelects()
			else:
				$CanyemFirst.hide()
				$CanyemSecond.hide()
				$CanyemThird.hide()
		
		pass
	if Input.is_action_pressed("p2_move_down"):
		print("P2down")
		if movimentsP2[0] == true and movimentsP2[2] == true and movimentsP2[1] == false:
			numAllsEnforcatsP2 += 1
			print(numAllsEnforcatsP2)
			var obj = get_node(allsP2[3])
			print(obj)
			if numAllsEnforcatsP2 <= 13:
				var next = currentPosAllsP2+1
				#print(str(alls.size()))
				#print(str(next))
				if allsP2.size() > next:
					var objectToShow = get_node(allsP2[currentPosAllsP2+1])
					objectToShow.show()
					$SecondPlayer/CanyemFirst.position = posCanyem1P2[currentPosAllsP2+1]
					#print("C1 X:"+str(posCanyem1[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$SecondPlayer/CanyemFirst.unselect(true)
					$SecondPlayer/CanyemSecond.position = posCanyem2P2[currentPosAllsP2+1]
					#print("C2 X:"+str(posCanyem2[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$SecondPlayer/CanyemSecond.unselect(false)
					$SecondPlayer/CanyemThird.position = posCanyem3P2[currentPosAllsP2+1]
					#print("C3 X:"+str(posCanyem2[currentPosAlls+1].x)+"Y:"+str(posCanyem1[currentPosAlls+1].y))
					$SecondPlayer/CanyemThird.unselect(false)
					currentPosAllsP2 += 1
				resetSelectsP2()
			else:
				$SecondPlayer/CanyemFirst.hide()
				$SecondPlayer/CanyemSecond.hide()
				$SecondPlayer/CanyemThird.hide()
		
		pass
		
