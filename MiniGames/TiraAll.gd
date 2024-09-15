extends Node2D

var currentPlayer = ""
var nextPartyReady = false
var endgame = false
var puntsP1 = 0
var puntsP2 = 0

var readyToStart = true

var currentDirection = "leftright"

var foratsValidsPosition = [
	{
		"name" = "forat1",
		"rangXmin" = 30,
		"rangXmax" = 68,
		"rangYmin" = 164,
		"rangYmax" = 190
	},
	{
		"name" = "forat2",
		"rangXmin" = 90,
		"rangXmax" = 129,
		"rangYmin" = 82,
		"rangYmax" = 100
	},
	{	
		"name" = "forat3",
		"rangXmin" = 150,
		"rangXmax" = 173,
		"rangYmin" = 55,
		"rangYmax" = 75
	},
	{
		"name" = "forat4",
		"rangXmin" = 140,
		"rangXmax" = 160,
		"rangYmin" = 130,
		"rangYmax" = 145
	},	
	{
		"name" = "forat5",
		"rangXmin" = 195,
		"rangXmax" = 225,
		"rangYmin" = 76,
		"rangYmax" = 100
	},
	{
		"name" = "forat6",
		"rangXmin" = 260,
		"rangXmax" = 290,
		"rangYmin" = 95,
		"rangYmax" = 120
	},
	{
		"name" = "forat7",
		"rangXmin" = 210,
		"rangXmax" = 246,
		"rangYmin" = 155,
		"rangYmax" = 180
	},
	{
		"name" = "forat8",
		"rangXmin" = 110,
		"rangXmax" = 140,
		"rangYmin" = 172,
		"rangYmax" = 200
	}
]
var is_Showing_Square = false	

func InitScreen():
	$Hud/Message2.hide()
	if Global.numPlayers == 2:
		$Hud/P2Time.position.x = 200
		$Hud/P2Time.text = " 0 "
		$Player1Punts2/PuntsP2.text = " 0 "
		
	$Hud/P1Time.text = " 0 "
	$Player1Punts/PuntsP1.text = " 0 "
	
	$Timer.wait_time = 25
	currentPlayer = "Player 1"
	#$Label.text = currentPlayer
	$CanvasLayer/tornJugador.text = "Jugador 1"
	#$MaTirAll.emit_signal("init")
	$MaTirAll/Allxoca.connect("entratForat", Callable(self,"entratForatAll"))
	$MaTirAll/Allxoca.connect("fora", Callable(self,"allfora"))
	
	$CanvasLayer.hide()
	$Player1Punts.hide()
	$Player1Punts2.hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	InitScreen()
	$MaTirAll.emit_signal("init")	
	#$SquareInformation.hide()
	readyToStart = true
	$RetryGame.menuRetry = false
	$RetryGame.currentGame = "TiraAll"
	
	pass # Replace with function body.
	
func continueOrUpdatePlayer():
	print($Timer.is_stopped())
	if $Timer.is_stopped() == false:
		StartMa()
	else:
		if currentPlayer == "Player 1":
			currentPlayer == "Player 2"
			readyToStart = true
		elif currentPlayer == "Player 2":
			endgame = true
		pass

func entratForatAll():
	continueOrUpdatePlayer()
func allfora():
	continueOrUpdatePlayer()
	 
func addPoints(point):
	if currentPlayer == "Player 1":
		puntsP1 += point
	elif currentPlayer == "Player 2":
		puntsP2 += point

func UpdateMarcador():
	$Hud/P1Time.text = str(puntsP1)
	$Hud/P2Time.text = str(puntsP2)
	$Player1Punts/PuntsP1.text = str(puntsP1)
	$Player1Punts2/PuntsP2.text = str(puntsP2)

func StartMa():
	$MaTirAll.emit_signal("start")
	currentDirection = "leftright"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countDown()
	pass

func _input(event):
	if Input.is_action_pressed("exit"):
		Global.goto_Jocs()
	
	if readyToStart == true:
		if event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
			$Hud/Message2.text = ""
			$Information.hide()
			$CanvasLayer.show()
			$Player1Punts.show()
			if Global.numPlayers == 2:
				$Player1Punts2.show()	
			readyToStart = false
			$Timer.wait_time = 25
			$Timer.start()
			StartMa()
	else:
		if event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
			if currentDirection == "leftright":
				$MaTirAll.emit_signal("updown")
				currentDirection = "updown"
			elif currentDirection == "updown":
				var hasDiana = dispararMaEsDiana($MaTirAll.position)
				$MaTirAll.emit_signal("obredits",hasDiana)				
				currentDirection = "dispara"

func addPuntuacio(name):
	if name == "forat5" or name == "forat8":
		print("8 punts")
		addPoints(8)
		#points += 8
	elif name == "forat3" or name == "forat4":
		print("10 punts")
		addPoints(10)
		#points += 10
	elif name == "forat1" or name == "forat2" or name == "forat6" or name == "forat7":
		print("5 punts")
		addPoints(5)
		#points += 5
	UpdateMarcador()
	continueOrUpdatePlayer()
	pass

func dispararMaEsDiana(position):
	var hasDiana = false
	for diana in foratsValidsPosition:
		var posX = position.x
		var posY = position.y
		var isXInRange = isBetWeenRanges(diana["rangXmax"], diana["rangXmin"],int(posX))
		var isYInRange = isBetWeenRanges(diana["rangYmax"], diana["rangYmin"],int(posY))
		if isXInRange and isYInRange:
			print(position)
			print("Diana!!! " + diana["name"])
			hasDiana = true
			addPuntuacio(diana["name"])
	#		print(position)
		else:
			pass
	return hasDiana

func isBetWeenRanges(max, min, pos):
	#print(str(max)+" "+str(min)+" "+str(pos))
	return (pos >= min) and (pos <= max)	

	pass
	
func countDown():
	$Hud/Message.text = str(int($Timer.time_left))
	$CanvasLayer/timer.text = str(int($Timer.time_left))

func _on_timer_timeout():
	print("Ha arribat a 0 Player:" + currentPlayer)
	$MaTirAll.emit_signal("stop")
	$Hud/Message2.show()
	
	if currentPlayer == "Player 1" and Global.numPlayers == 2:
		$Hud/Message2.text = " Proxim player"
		$Information.show()
		$Information/Label.text = " Proxim player Jugador 2"
		currentPlayer = "Player 2"
		#$Label.text = currentPlayer
		$CanvasLayer/tornJugador.text = "Jugador 2"
		readyToStart = true
	elif currentPlayer == "Player 2":
		var guanya = 0
		if Global.numPlayers == 2:
			if puntsP1 > puntsP2:
				guanya = puntsP1
				Global.setScore(puntsP1)
				$Hud/Message2.text = "Guanya P1"	
				$Information.show()
				$Information/Label.text = " Guanya P1"
				
			else:
				guanya = puntsP2
				Global.setScore(puntsP2)
				$Hud/Message2.text = "Guanya P2"	
				$Information.show()
				$Information/Label.text = "Guanya P2"
		
		readyToStart = false 
		endgame = true
		if Global.numPlayers == 2:
			$TimerGotoRecords.start()
			pass
		else:
			Global.setScore(puntsP1)
			$RetryGame.menuRetry = true
			$RetryGame.ShowRetry()
	else:
		Global.setScore(puntsP1)
		$Hud/Message2.text = "Fi de la partida"	
		$Information.show()
		$Information/Label.text = " Fi de la partida"
		readyToStart = false
		endgame = true
		$RetryGame.menuRetry = true
		$RetryGame.ShowRetry()
	pass # Replace with function body.


func _on_timer_square_information_timeout():
	$TimerSquareInformation.stop()
	pass # Replace with function body.


func _on_timer_goto_records_timeout() -> void:

	if await Global.ShouldAddScore():
		Global.goto_SaveRecords()
	else:
		Global.goto_Jocs()
	pass # Replace with function body.
