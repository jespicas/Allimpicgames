extends Node2D

var possibleMovements = ["up","left","right","button", "down"]
var random = RandomNumberGenerator.new()

var currentMovement = [] # ["up","left","right","button","down"]
var movements = []
var timeP1 = 0
var timeP2 = 0

var shouldbeCheck = true
var timeOkP1 =0
var timeOkP2 =0

var next = false
var numMovementsP1 = 4
var numMovementsP2 = 4

var P1finish = false
var P2finish = false

var scoreSent = false
var willSendScore = false

var started = false
var timerFinishGame = false

# Called when the node enters the scene tree for the first time.
func _ready():
	fillArrCurrentMovement()
	$Hud.hideMessageP1()
	$Hud.hideMessageP2()
	$RetryGame.menuRetry = false
	$RetryGame.currentGame = "AgafaAlls"
	
	$RecolectorP1.set_Participant1(true)
	$RecolectorP2.set_Participant1(false)
	$Timer.wait_time = 4
	$Timer.start()
	$Hud.hideTiming()
	
	$Player1.hide()
	$Player2.hide()
	pass # Replace with function body.

func fillArrCurrentMovement():
	for j in 4:
		currentMovement = []
		for n in 5:
			#random = RandomNumberGenerator.new()
			var rndPos = random.randi_range(0,4)
			#print(rndPos)
			currentMovement.append(possibleMovements[rndPos])
		movements.append(currentMovement)
	#print(movements)
	$RecolectorP1.set_CurrentMovement(movements)
	$RecolectorP1.set_Movements(movements)
	$RecolectorP1.set_name_player("P1")
	$RecolectorP1.connect("emitButtonWellPressed", Callable(self, "buttonWellPressedP1"))
	$RecolectorP1.connect("emitResetWellButtons", Callable(self, "resetbuttonsP1"))	
	$RecolectorP1.connect("emitItsOk", Callable(self, "P1ItsOk"))
	$RecolectorP1.connect("emitFinish", Callable(self, "P1Finish"))
	$RecolectorP1.connect("emitEliminaAll", Callable(self, "P1EliminaAll"))
	$RecolectorP1.connect("emitShownAll", Callable(self,"P1ShownAll"))
	if Global.numPlayers == 2:
		$RecolectorP2.set_CurrentMovement(movements)
		$RecolectorP2.set_Movements(movements)
		$RecolectorP2.set_name_player("P2")
		$RecolectorP2.connect("emitButtonWellPressed", Callable(self, "buttonWellPressedP2"))
		$RecolectorP2.connect("emitResetWellButtons", Callable(self, "resetbuttonsP2"))
		$RecolectorP2.connect("emitItsOk", Callable(self, "P2ItsOk"))	
		$RecolectorP2.connect("emitFinish", Callable(self, "P2Finish"))
		$RecolectorP2.connect("emitEliminaAll", Callable(self, "P2EliminaAll"))
		$RecolectorP2.connect("emitShownAll", Callable(self,"P2ShownAll"))
	else:
		$CanvasLayer.hide()
		$CanvasLayer2.hide()
		$"5controlsleft2".hide()
		$RecolectorP2.hide()
		
	fillCurrentMovemnt()

func P2ShownAll(pos,name):
	if pos == 0:
		$all1P2.show()
	if pos == 1:
		$all2P2.show()
	if pos == 2:
		$all3P2.show()
	pass
	
func P1ShownAll(pos,name):
	if pos == 0:
		$all1P1.show()
	if pos == 1:
		$all2P1.show()
	if pos == 2:
		$all3P1.show()
	pass
	
func P2EliminaAll(pos, name):
	if pos == 0:
		$all1P2.hide()
	if pos == 1:
		$all2P2.hide()
	if pos == 2:
		$all3P2.hide()
	pass
func P1EliminaAll(pos, name):
	if pos == 0:
		$all1P1.hide()
	if pos == 1:
		$all2P1.hide()
	if pos == 2:
		$all3P1.hide()
	pass
func P1Finish(time):
	P1finish = true
	timeP1 = time
	#$Hud.show_messageP1(str(timeP1))
	$Player1.show()
	$Player1/Punts.text = str(timeP1).substr(0,5) + " sec"
	#$Hud.show_message("MoltBE P1" + str(time) + " Prem for next")
func P2Finish(time):
	P2finish = true
	timeP2 = time
	#$Hud.show_messageP2(str(timeP2))
	$Player2.show()
	$Player2/Punts.text = str(timeP2).substr(0,5) + " sec"
	#$Hud.show_message("MoltBE P2" + str(time) + " Prem for next")

func P1ItsOk(position):
	$"5controlsleft".FillControls(movements[position])
	timeP1 += timeOkP1
	timeOkP1 = 0
	shouldbeCheck = false
	next = true	
	moveNextRecolector("P1")

func P2ItsOk(position):
	$"5controlsleft2".FillControls(movements[position])
	timeP2 += timeOkP2
	timeOkP2 = 0
	shouldbeCheck = false
	next = true	
	moveNextRecolector("P2")
			
func fillCurrentMovemnt():
	$"5controlsleft".FillControls(movements[0])
	if Global.numPlayers == 2:
		$"5controlsleft2".FillControls(movements[0])

func resetbuttonsP1():
	$"5controlsleft".reset()

func resetbuttonsP2():
	$"5controlsleft2".reset()

func buttonWellPressedP1(position):
	$"5controlsleft".changeVisibility(position)
	pass		

func buttonWellPressedP2(position):
	$"5controlsleft2".changeVisibility(position)
	pass		

func animRecolector():
	$RecolectorP1.playing = true

func _process(delta):
	countDown()
	if shouldbeCheck == true:
		timeOkP1 += delta
		timeOkP2 += delta
	if Global.numPlayers == 2:
		if P1finish == true and P2finish == true :
			var guanya = ""
			if timeP1 > timeP2:
				guanya = "P2"
				Global.setScore(str(timeP2).substr(0,5))
			else:
				guanya = "P1"
				Global.setScore(str(timeP1).substr(0,5))
			$Hud.show_message("Guanya " + guanya)
			if timerFinishGame == false:
				$TimerGoToRecords.start()
				timerFinishGame = true
				print("finishgame")

	else:
		if Global.numPlayers == 1 and P1finish == true:
			Global.setScore(str(timeP1).substr(0,5))
			$RetryGame.menuRetry = true
			$RetryGame.ShowRetry()
			
	

func moveNextRecolector(player):
	if player == "P1":
		#$RecolectorP1.playing = false
		$RecolectorP1.position.y = $RecolectorP1.position.y + 40
		next = false		
	if player == "P2":
		#$RecolectorP2.playing = false
		$RecolectorP2.position.y = $RecolectorP2.position.y + 40
		next = false		

func countDown():
	if $Timer.is_stopped() == false:
		if int($Timer.time_left) == 0 :
			$Hud.show_message("JA!")
			started = true
			$RecolectorP1.set_start()
			$RecolectorP2.set_start()
		else:
			$Hud.show_message(str(int($Timer.time_left)))

func _on_Timer_timeout():
	$Hud.hideMessage()
	print("timeout")	
	pass # Replace with function body.


func _on_timer_go_to_records_timeout() -> void:
	print("timeoutGotoREcords")
	# Mirar si ha de guardar records
	# El record esta dintre dels 5 ?
	
	if await Global.ShouldAddScore():
		Global.goto_SaveRecords()
	else:
		Global.goto_Jocs()
	#if Global.ShouldAddScore():
	#	Global.goto_SaveRecords()
	#else:
	#	Global.goto_Jocs()
	pass # Replace with function body.
