extends Node2D

var orderKeyPress = [false,false,false,false]
var orderKeyPressP1 = [false,false,false,false]
var lastPress = ""
var lastPressP1 = ""
var hafetunavolta = false
var hafetunavoltaP1 = false
var numvoltes = 0
var numvoltesP1 = 0

var time = 0
var timeP1 = 0
var start = null
var startP1 = null
var numeroEsquerraXafadesAll = 0
var numeroDretaXafadesAll = 0

var madeMorterEsquerraMoviment = false
var madeMorterDretaMoviment = false
var animationfinished = true
var animationfinishedP1 = true
var estasFent = false
var estasFentP1 = false

var timeLastInputPress 
var timeLastInputPressP1
 
var is_Showing_Square = false
var is_SquareReadyToHide = false

var is_SquareP2_Shown = false
var is_SquareP1_Shown = false
var is_SquareP2_ShownOneTime = false
var is_SquareP1_ShownOneTime = false

var puntOKP2 = 0
var hasStartOKP2 = false
var puntsFailP2 = 0
var puntOKP1 = 0
var hasStartOKP1 = false
var puntsFailP1 = 0
var finishedGame = false

func _input(event):
	if is_Showing_Square == false:
		if estasFentP1 == true:
			timeLastInputPressP1 = timeP1
			if Input.is_action_pressed("p1_move_up"):
#				print("up")
				#$Allioli.emit_signal("mou_amunt")
				$AllioliCenital1.emit_signal("mou_amunt_fer")
				if (lastPressP1 == "" or lastPressP1 == "left"):
					orderKeyPressP1[0] = true			
					if (lastPressP1 == "left" and orderKeyPressP1[0] == true and orderKeyPressP1[1] == true and orderKeyPressP1[2] == true and orderKeyPressP1[3] == true ):
						hafetunavoltaP1 = true
						numvoltesP1 += 1
#						print(numvoltes)
#						print(start)
						if startP1 != null:
							$VelocitatIndicatorP1.emit_signal("update_health", startP1 * 100)
							print(startP1 * 100)
							if startP1 >= 0.25 and startP1 <= 0.4:
								#var textParticipant = [
								#	"Bona segueix ",
								#	"aquesta",
								#	"velocitat"
								#]
								#$CanvasLayer2/SquareInformationP1.ShowSquareP2(30,70,30,100,120,70,120,100,textParticipant,true)
								puntOKP1 += 1
								hasStartOKP1 = true
								print (" bona segueix aquesta velocitat")
							else:
								$VelocitatIndicatorP1.emit_signal("update_health_critical", startP1 * 100)
								if hasStartOKP1 == true:
									puntsFailP1 += 1
								print ( " eis .. vigila ")
#						print(time)
						startP1 = timeP1
						timeP1 = 0
						orderKeyPressP1 = [true,false,false,false]
					lastPressP1 = "up"
			if Input.is_action_pressed("p1_move_right"):
				#$Allioli.emit_signal("mou_esquerra")
				$AllioliCenital1.emit_signal("mou_dreta_fer")
				if (lastPressP1 == "up"):			
					orderKeyPressP1[1] = true
					lastPressP1 = "right"
			if Input.is_action_pressed("p1_move_down"):
				#$Allioli.emit_signal("mou_avall")
				$AllioliCenital1.emit_signal("mou_avall_fer")
				if (lastPressP1 == "right"):			
					orderKeyPressP1[2] = true
					lastPressP1 = "down"
			if Input.is_action_pressed("p1_move_left"):
				#$Allioli.emit_signal("mou_dreta")
				$AllioliCenital1.emit_signal("mou_esquerra_fer")
				if (lastPressP1 == "down"):			
					orderKeyPressP1[3] = true
					lastPressP1 = "left"				
			if Input.is_action_pressed("p1_press_button"):
				#print("moud")
				$BiberoOliP1.show()
				$BiberoOliP1.emit_signal("mou")
				$OliIndicatorP1.emit_signal("update_health", 100)
				$OlitTimerP1.start(5)

			$VelocitatIndicatorP1.show()
			$VelocitatP1.show()
			$OliP1.show()
			$OliIndicatorP1.show()
			$BackgroundOliP1.show()
			$BackgroundVelocitatP1.show()
		else:
			if Input.is_action_just_released("p1_press_button"):		
				madeMorterEsquerraMoviment = true		
				if madeMorterEsquerraMoviment == true && animationfinishedP1 == true:
					$AllioliCenital1.emit_signal("mou_avall")
					numeroEsquerraXafadesAll += 1			
		if estasFent == true:
			timeLastInputPress = time
			if Input.is_action_pressed("p2_move_up"):
#				print("up")
				#$Allioli.emit_signal("mou_amunt")
				$AllioliCenital2.emit_signal("mou_amunt_fer")
				if (lastPress == "" or lastPress == "left"):
					orderKeyPress[0] = true			
					if (lastPress == "left" and orderKeyPress[0] == true and orderKeyPress[1] == true and orderKeyPress[2] == true and orderKeyPress[3] == true ):
						hafetunavolta = true
						numvoltes += 1
#						print(numvoltes)
#						print(start)
						if start != null:
							$VelocitatIndicatorP2.emit_signal("update_health", start * 100)
							if start >= 0.25 and start <= 0.4:
								#var textParticipant = [
								#	"Bona segueix ",
								#	"aquesta",
								#	"velocitat"
								#]
								#$CanvasLayer3/SquareInformationP2.ShowSquareP2(190,70,190,100,280,70,280,100,textParticipant,true)
								puntOKP2 += 1
								hasStartOKP2 = true
								print (" bona segueix aquesta velocitat")
							else:
								$VelocitatIndicatorP2.emit_signal("update_health_critical", start * 100)
								if hasStartOKP2 == true:
									puntsFailP2 += 1
								print ( " eis .. vigila ")
#						print(time)
						start = time
						time = 0
						orderKeyPress = [true,false,false,false]
					lastPress = "up"
			if Input.is_action_pressed("p2_move_right"):
				#$Allioli.emit_signal("mou_esquerra")
				$AllioliCenital2.emit_signal("mou_dreta_fer")
				if (lastPress == "up"):			
					orderKeyPress[1] = true
					lastPress = "right"
			if Input.is_action_pressed("p2_move_down"):
				#$Allioli.emit_signal("mou_avall")
				$AllioliCenital2.emit_signal("mou_avall_fer")
				if (lastPress == "right"):			
					orderKeyPress[2] = true
					lastPress = "down"
			if Input.is_action_pressed("p2_move_left"):
				#$Allioli.emit_signal("mou_dreta")
				$AllioliCenital2.emit_signal("mou_esquerra_fer")
				if (lastPress == "down"):			
					orderKeyPress[3] = true
					lastPress = "left"
			if Input.is_action_pressed("p2_press_button"):
				#print("moud")
				$BiberoOliP2.show()
				$BiberoOliP2.emit_signal("mou")
				$OliIndicatorP2.emit_signal("update_health", 100)
				$OlitTimerP2.start(5)
			if Input.is_action_pressed("p2_press_button"):
				pass
			$VelocitatIndicatorP2.show()
			$VelocitatP2.show()
			$OliP2.show()
			$OliIndicatorP2.show()	
			$BackgroundOliP2.show()
			$BackgroundVelocitatP2.show()
		else:
			if Input.is_action_just_released("p2_press_button"):		
				madeMorterDretaMoviment = true		
				if madeMorterDretaMoviment == true && animationfinished == true:
					$AllioliCenital2.emit_signal("mou_avall")
					numeroDretaXafadesAll += 1					
	else:
		if is_SquareReadyToHide == true:
			if Input.is_action_just_released("p2_press_button") or Input.is_action_just_released("p1_press_button"):
				squarefinished()
# Called when the node enters the scene tree for the first time.
func _ready():
	$RetryGame.menuRetry = false
	$RetryGame.currentGame = "ConcursAlliOli"
	$RetryGame.colorBlack()	
	$AllioliCenital2.set_dreta()
	$VelocitatIndicatorP2.emit_signal("update_health_critical", 50)
	$VelocitatIndicatorP1.emit_signal("update_health_critical", 50)
	
	$OliIndicatorP2.emit_signal("update_health_critical", 50)
	$OliIndicatorP1.emit_signal("update_health_critical", 50)
	
	$AllioliCenital2.connect("finish_timer", Callable(self, "finisthTimerP2"))
	$AllioliCenital2.connect("animationFinish", Callable(self, "animationFinishP2"))
	$AllioliCenital2.connect("animationStarted", Callable(self, "animationStarted"))
	
	$AllioliCenital1.connect("finish_timer", Callable(self, "finisthTimerP1"))
	$AllioliCenital1.connect("animationFinish", Callable(self, "animationFinishP1"))
	$AllioliCenital1.connect("animationStarted", Callable(self, "animationStartedP1"))
	
	$BiberoOliP1.setPosition(100)
	$BiberoOliP1.setFlip(true)
	$BiberoOliP1.connect("animation_finish", Callable(self, "animationBiberoFinishedP1"))
		
	$BiberoOliP2.connect("animation_finish", Callable(self, "animationBiberoFinished"))
	#$CanvasLayer/SquareInformation.connect("allTextShown", Callable(self,"squarefinished"))
	
	#$CanvasLayer3/SquareInformationP2.connect("hiddenSquare", Callable(self,"hiddenSquare2"))
	#$CanvasLayer/SquareInformation.show()
	$Info.show()
	is_Showing_Square = true
	var text = [
		"Primer de tots has de xafar els alls amb el ma",
		"de morter. lavors has de comencar a rodar el ",
		"morter pero a una velocitat ni massa lent ni",
		"rapid. Tens un indicador i si es posa verd vol",
		"dir que vas a la velocitat adecuada.",
		"Tambe tens un indicador d'oli, s'ha d' emplenar",
		"tambe al nivell que toca emplenes amb el boto  ",
		"de disparar, quan no  dispares llavors para ",
		"Vigila amb la velocitat i quantitat d' oli    ",
		"o l'allioli es negara   "
	]
	#$CanvasLayer/SquareInformation.ShowSquare(text)

	$Hud.hideMessageP1()
	$Hud.hideMessageP2()
	$Hud.hideMessage()
	$Hud.setColor("black")
	$Hud.hideTiming()	
	$Hud.connect("timeexpired",Callable(self,"finished"))
	$InfoPlayer1.hide()
	$InfoPlayer2.hide()
	pass # Replace with function body.
func finished():
	print("TimeExpired")
	estasFent = false
	is_Showing_Square = true
	finishedGame = true
	
	$InfoPlayer1.show()
	$InfoPlayer1/Label.text = " Quantitat "
	$InfoPlayer1/Label2.text = " all i oli "
	$InfoPlayer1/Label3.text = " "+str(puntOKP1)+" ml"
	#if Global.numPlayers == 2:
	#var textParticipant = [
	#	"Quantitat",
	#	"all i oli",
	#	"   "+str(puntOKP2)+" ml"
	#]
	#$InfoPlayer2/SquareInformationP2.ShowSquareFixed(190,70,190,100,280,70,280,100,textParticipant)
	if Global.tipusdeJoc == "practicar":
		pass
	else:
		$InfoPlayer2.show()
		$InfoPlayer2/Label.text = " Quantitat "
		$InfoPlayer2/Label2.text = " all i oli "
		$InfoPlayer2/Label3.text = " "+str(puntOKP2)+" ml"
	#textParticipant = [
	#	"Quantitat",
	#	"all i oli",
	#	"   "+str(puntOKP1)+" ml"
	#]
	#$InfPlayer1/SquareInformationP1.ShowSquareFixed(30,70,30,100,120,70,120,100,textParticipant)		
	
	$RetryGame.menuRetry = true
	$RetryGame.ShowRetry()	

	pass	
func animationBiberoFinished():
	$BiberoOliP2.hide()
	
func animationBiberoFinishedP1():
	$BiberoOliP1.hide()
	
func hiddenSquare2():
	pass
	#if is_SquareP2_ShownOneTime == true:
		#print("onetime")
		#is_SquareP2_Shown = false
		#$CanvasLayer3/SquareInformationP2.hide()
	
func squarefinished():
	$Hud.showTiming()
	$Hud/Timer.start()
	is_Showing_Square = false
	$Info.hide()
	
	$InfoPlayer1.show()
	$InfoPlayer1/Label.text = " "
	$InfoPlayer1/Label2.text = " xafa els alls "
	$InfoPlayer1/Label3.text = " prem buto "
	$InfoPlayer1/TimerInfoPlayer1.start()
	
	if Global.tipusdeJoc == "practicar":
		$InfoPlayer2.hide()
		$AllioliCenital2.hide()
	else:
		$InfoPlayer2.show()
		$InfoPlayer2/Label.text = " "
		$InfoPlayer2/Label2.text = " xafa els alls "
		$InfoPlayer2/Label3.text = " prem buto "
		$InfoPlayer2/TimerInfoPlayer2.start()

	
func finisthTimerP2():
#	print("finishtimer")
	madeMorterDretaMoviment = false

func finisthTimerP1():
#	print("finishtimer")
	madeMorterEsquerraMoviment = false	
func animationFinishP1():
#	print("animationfinish")
	animationfinishedP1 = true
	$AllioliCenital1.emit_signal("mou_amunt")
		
func animationFinishP2():
#	print("animationfinish")
	animationfinished = true
	$AllioliCenital2.emit_signal("mou_amunt")
func animationStarted():
	animationfinished = false
	
func animationStartedP1():
	animationfinishedP1 = false	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	timeP1 += delta
	if numeroDretaXafadesAll == 10:
		#$AllioliCenital.hide()
		if is_SquareP2_Shown == false:
			is_SquareP2_ShownOneTime = true
			is_SquareP2_Shown = true
			$InfoPlayer2.show()
			$InfoPlayer2/TimerInfoPlayer2.start()
			$InfoPlayer2/Label.text = "Mou joystick "
			$InfoPlayer2/Label2.text = "a velocitat"
			$InfoPlayer2/Label3.text = "constant"
			#var textParticipant = [
			#	"Mou joystick ",
			#	"velocitat",
			#	"constant"
			#]
			#$InfoPlayer2/SquareInformationP2.ShowSquareP2(190,70,190,100,280,70,280,100,textParticipant,true)

		estasFent = true		
		if finishedGame == true:
			$VelocitatIndicatorP2.hide()
			$VelocitatP2.hide()
			$OliP2.hide()
			$OliIndicatorP2.hide()
			$BackgroundOliP2.hide()
			$BackgroundVelocitatP2.hide()
			estasFent = false

		if timeLastInputPress != null and timeLastInputPress >= 0.9:
			$VelocitatIndicatorP2.emit_signal("update_health_critical", timeLastInputPress * 100)
			#print("1 segon sense premer res?")
#		print("estasFentTrue")
		#$Allioli.show()
	if numeroEsquerraXafadesAll == 10:
		#$AllioliCenital.hide()
		if is_SquareP1_Shown == false:
			is_SquareP1_ShownOneTime = true
			is_SquareP1_Shown = true
			$InfoPlayer1.show()
			$InfoPlayer1/TimerInfoPlayer1.start()
			$InfoPlayer1/Label.text = "Mou joystick "
			$InfoPlayer1/Label2.text = "a velocitat"
			$InfoPlayer1/Label3.text = "constant"
			#var textParticipant = [
			#	"Mou joystick ",
			#	"velocitat",
			#	"constant"
			#]
			#$InfoPlayer1/SquareInformationP1.ShowSquareP2(30,70,30,100,120,70,120,100,textParticipant,true)

		estasFentP1 = true		
		if finishedGame == true:
			$VelocitatIndicatorP1.hide()
			$VelocitatP1.hide()
			$OliP1.hide()
			$OliIndicatorP1.hide()
			$BackgroundOliP1.hide()
			$BackgroundVelocitatP1.hide()
			estasFentP1 = false

		if timeLastInputPressP1 != null and timeLastInputPressP1 >= 0.9:
			$VelocitatIndicatorP1.emit_signal("update_health_critical", timeLastInputPressP1 * 100)
			#print("1 segon sense premer res?")
#		print("estasFentTrue")
		#$Allioli.show()		
	pass

func _on_olit_timer_p_2_timeout():
	$OliIndicatorP2.emit_signal("update_health_critical", 50)
	pass # Replace with function body.

func _on_olit_timer_p_1_timeout():
	$OliIndicatorP1.emit_signal("update_health_critical", 50)
	pass # Replace with function body.


func _on_wait_readyto_hide_timeout() -> void:
	is_SquareReadyToHide = true
	pass # Replace with function body.


func _on_timer_info_player_2_timeout() -> void:
	$InfoPlayer2.hide()
	$InfoPlayer2/TimerInfoPlayer2.stop()
	pass # Replace with function body.


func _on_timer_info_player_1_timeout() -> void:
	$InfoPlayer1.hide()
	$InfoPlayer1/TimerInfoPlayer1.stop()
	pass # Replace with function body.
