extends Node2D

var iterationsP1 = 0
var iterationsP2 = 0

var numberprogressP2 = 1
var numberprogressP1 = 1
var sumaP2 = true
var sumaP1 = true

var positionAvi 
var positionBald

var positionXBirraP1
var positionXBirraP2
var aviPos 
var baldPos

var shownOneTime = false
var moveBirraP2 = false
var moveBirraP1 = false
var readyP2 = false
var readyP1 = false
var finishGame = false

var puntsP2 = 0
var puntsP1 = 0

var participant2Disabled = false

func StartParticipant1():
	baldPos = randf_range(0, 100)
	positionBald = $BaldBarFiraAll.position.x
	$BaldBarFiraAll/CharacterBody2D/AnimatedSprite2D.flip_h = true
	$HealthBarP1.setupHelthBar("LeftToRight")
	$BaldBarFiraAll/CharacterBody2D.connect("arrived",Callable(self,"BaldArrived"))
	$BaldBarFiraAll/CharacterBody2D.connect("out",Callable(self,"BaldOut"))
	$BaldBarFiraAll/CharacterBody2D.checkposition = true
	$BaldBarFiraAll/CharacterBody2D.moveTo(Vector2(baldPos,0))	
			
	pass
func StartParticipant2():
	if participant2Disabled == true:
		$AviBarFiraAll.hide()
		$HealthBarP2.hide()
		$BirrasP2.hide()
	else:
		aviPos = randf_range(0, -80)
		positionAvi = $AviBarFiraAll.position.x
		$AviBarFiraAll/CharacterBody2D.connect("arrived",Callable(self,"AviArrived"))
		$AviBarFiraAll/CharacterBody2D.connect("out",Callable(self,"AviOut"))
		$AviBarFiraAll/CharacterBody2D.checkposition = true
		$AviBarFiraAll/CharacterBody2D.moveTo(Vector2(	aviPos,0))	
	
	pass
# Called when the node enters the scene tree for the first time.
var birraP2PosicioCorrecte = false
var birraP1PosicioCorrecte = false

func _ready():
	#participant2Disabled = true
	$RetryGame.menuRetry = false
	$RetryGame.currentGame = "TiralaBirra"
	$RetryGame.colorBlack()
	
	if Global.numPlayers == 1:
		participant2Disabled = true
	StartParticipant1()
	StartParticipant2()
	positionXBirraP1 = $BirrasP1.position.x
	positionXBirraP2 = $BirrasP2.position.x
	$BirrasP2/CharacterBody2D.connect("arrived",Callable(self,"BottleArrived"))
	$BirrasP1/CharacterBody2D.connect("arrived",Callable(self,"BottleArrivedP1"))

	$Hud.hideMessageP1()
	$Hud.hideMessageP2()
	$Hud.hideMessage()
	$Hud.setColor("black")	
	$Hud/Timer.start()
	$Hud.connect("timeexpired",Callable(self,"finished"))
	pass # Replac/e with function body.

func finished():
	
	if Global.numPlayers == 2:
		if puntsP1 > puntsP2:
			$Hud.show_message("Guanya Jugador 1")
			Global.setScore(puntsP1)
		else:
			$Hud.show_message("Guanya Jugador 2")
			Global.setScore(puntsP2)
	$TimerP1.stop()
	$TimerP2.stop()
	readyP2 = false
	finishGame = true
	$HealthBarP2.emit_signal("reset") 
	$HealthBarP1.emit_signal("reset") 
	$HealthBarP1.hide()
	$HealthBarP2.hide()
	if Global.numPlayers == 2:
		$TimerGotoRecords.start()		
	else:
		Global.setScore(puntsP1)
		$RetryGame.menuRetry = true
		$RetryGame.ShowRetry()
	pass
func BaldArrived():
	$BaldBarFiraAll/CharacterBody2D/AnimatedSprite2D.stop()
	readyP1 = true
	birraP1PosicioCorrecte = false
	$BirrasP1.show()
	
func AviOut():	
	readyP2 = false
	aviPos = randf_range(0, -80)
	
	$AviBarFiraAll/CharacterBody2D.position.x = 290
	$AviBarFiraAll/CharacterBody2D.checkposition = true
	$AviBarFiraAll/CharacterBody2D.animationToPlay = "default"
	$AviBarFiraAll/CharacterBody2D.moveTo(Vector2(	aviPos,0))
	$textProgressP2.text = ""
	$TimerP2.start()

	$BirrasP2/CharacterBody2D.checkposition = false
	$BirrasP2/CharacterBody2D.direction = "left"
	
	if birraP2PosicioCorrecte == false:
		$BirrasP2.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP2.hide()
		await get_tree().create_timer(0.2).timeout
		$BirrasP2.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP2.hide()
		await get_tree().create_timer(0.2).timeout
		$BirrasP2.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP2.hide()
	
	var birraposition = $BirrasP2/CharacterBody2D.position.x		
	var positioAccordingBar = float(numberprogressP2)*82/100
	$BirrasP2/CharacterBody2D.checkposition = true
	$BirrasP2/CharacterBody2D/AnimatedSprite2D.play("default")
	$BirrasP2/CharacterBody2D.moveTo(Vector2(0,0))
	
func BaldOut():	
	readyP1 = false
	baldPos = randf_range(0, 100)
	
	$BaldBarFiraAll/CharacterBody2D.position.x = 0
	$BaldBarFiraAll/CharacterBody2D.checkposition = true
	$BaldBarFiraAll/CharacterBody2D.animationToPlay = "default"
	$BaldBarFiraAll/CharacterBody2D.moveTo(Vector2(	baldPos,0))
	$textProgressP1.text = ""
	$TimerP1.start()

	$BirrasP1/CharacterBody2D.checkposition = false
	$BirrasP1/CharacterBody2D.direction = "right"
	if birraP1PosicioCorrecte == false:
		$BirrasP1.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP1.hide()
		await get_tree().create_timer(0.2).timeout
		$BirrasP1.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP1.hide()
		await get_tree().create_timer(0.2).timeout
		$BirrasP1.show()
		await get_tree().create_timer(0.2).timeout
		$BirrasP1.hide()
	
	var birraposition = $BirrasP1/CharacterBody2D.position.x		
	var positioAccordingBar = float(numberprogressP1)*94/100
	$BirrasP1/CharacterBody2D.checkposition = true
	$BirrasP1/CharacterBody2D/AnimatedSprite2D.play("default")
	$BirrasP1/CharacterBody2D.moveTo(Vector2(0,0))
			
func AviArrived():	
	$AviBarFiraAll/CharacterBody2D/AnimatedSprite2D.stop()	
	readyP2 = true
	birraP2PosicioCorrecte = false
	$BirrasP2.show()

func BottleArrived():
	$BirrasP2/CharacterBody2D/AnimatedSprite2D.stop()
	if $BirrasP2/CharacterBody2D.direction == "left":
		$BirrasP2/CharacterBody2D.direction = "right"
		$BirrasP2/CharacterBody2D.position.x = 0
			
	if moveBirraP2 == true:
		moveBirraP2 = false		
		var aviCurrentPosition = positionAvi+aviPos
		var divit100 = float(numberprogressP2)/100
		var result = divit100*82
		var birraPosition = result+208
	
		if birraPosition+10 >= aviCurrentPosition and birraPosition-10 <= aviCurrentPosition:
			$AviBarFiraAll/CharacterBody2D.animationToPlay = "birra"
			$BirrasP2.hide()
			$BirrasP2/CharacterBody2D.position.x = 0
			$BirrasP2/CharacterBody2D.checkposition = true
			$BirrasP2/CharacterBody2D/AnimatedSprite2D.play("default")
			$BirrasP2/CharacterBody2D.moveTo(Vector2(0,0))
			puntsP2 = puntsP2 + 100
			birraP2PosicioCorrecte = true
			#$Hud.show_messageP2(str(puntsP2))
			$Participant2Punts2/Punts.text = str(puntsP2)
		else:
			$AviBarFiraAll/CharacterBody2D.animationToPlay = "default"
			var puntsProximitat = birraPosition - aviCurrentPosition
			if puntsProximitat <= 10:
				puntsP2 = puntsP2 + 90
			elif puntsProximitat <= 20:
				puntsP2 = puntsP2 + 80
			elif puntsProximitat <= 30:
				puntsP2 = puntsP2 + 70
			elif puntsProximitat <= 40:
				puntsP2 = puntsP2 + 60
			elif puntsProximitat <= 50:
				puntsP2 = puntsP2 + 50
			elif puntsProximitat <= 60:
				puntsP2 = puntsP2 + 40
			elif puntsProximitat <= 70:
				puntsP2 = puntsP2 + 30
			elif puntsProximitat <= 80:
				puntsP2 = puntsP2 + 20
			elif puntsProximitat <= 90:	
				puntsP2 = puntsP2 + 10
				
			$Participant2Punts2/Punts.text = str(puntsP2)
		RestartAvi()

func BottleArrivedP1():
	$BirrasP1/CharacterBody2D/AnimatedSprite2D.stop()

	if $BirrasP1/CharacterBody2D.direction == "right":
		$BirrasP1/CharacterBody2D.direction = "left"
		$BirrasP1/CharacterBody2D.position.x = 0
			
	if moveBirraP1 == true:
		moveBirraP1 = false		
		var divit100 = float(numberprogressP2)/100
		var result = divit100*82
		var birraPosition = result+208
		var baldCurrentPosition = 100 -float(baldPos)
		
		if numberprogressP1+5 >= baldCurrentPosition and numberprogressP1-5 <= baldCurrentPosition:
			$BaldBarFiraAll/CharacterBody2D.animationToPlay = "birra"
			$BirrasP1.hide()
			$BirrasP1/CharacterBody2D.position.x = 0
			$BirrasP1/CharacterBody2D.checkposition = true
			$BirrasP1/CharacterBody2D/AnimatedSprite2D.play("default")
			$BirrasP1/CharacterBody2D.moveTo(Vector2(0,0))
			puntsP1 = puntsP1 + 100
			birraP1PosicioCorrecte = true
			$Participant1Punts/Punts.text = str(puntsP1)
		else:
			var puntsProximitat = baldCurrentPosition - birraPosition
			if puntsProximitat <= 10:
				puntsP1 = puntsP1 + 90
			elif puntsProximitat <= 20:
				puntsP1 = puntsP1 + 80
			elif puntsProximitat <= 30:
				puntsP1 = puntsP1 + 70
			elif puntsProximitat <= 40:
				puntsP1 = puntsP1 + 60
			elif puntsProximitat <= 50:
				puntsP1 = puntsP1 + 50
			elif puntsProximitat <= 60:
				puntsP1 = puntsP1 + 40
			elif puntsProximitat <= 70:
				puntsP1 = puntsP1 + 30
			elif puntsProximitat <= 80:
				puntsP1 = puntsP1 + 20
			elif puntsProximitat <= 90:	
				puntsP1 = puntsP1 + 10

			$Participant1Punts/Punts.text = str(puntsP1)
		RestartBald()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func RestartBald():
	baldPos = randf_range(0, 100)
	$BaldBarFiraAll/CharacterBody2D.checkposition = true
	$BaldBarFiraAll/CharacterBody2D.moveTo(Vector2(100,210))
		
func RestartAvi():
	aviPos = randf_range(0, -80)
	$AviBarFiraAll/CharacterBody2D.checkposition = true
	$AviBarFiraAll/CharacterBody2D.moveTo(Vector2(	-80,210))
	pass

func _input(event):
	if Input.is_action_pressed("exit"):
		Global.goto_Jocs()
	
	if participant2Disabled == false and event.is_action_pressed("p2_press_button") and readyP2 == true && finishGame == false:
		$TimerP2.stop()
		$textProgressP2.text = str(numberprogressP2)+" %"
		var birraposition = $BirrasP2/CharacterBody2D.position.x		
		var positioAccordingBar = float(numberprogressP2)*90/100
		var ab = birraposition + positioAccordingBar
		
		$BirrasP2/CharacterBody2D.checkposition = true
		$BirrasP2/CharacterBody2D/AnimatedSprite2D.play("default")
		$BirrasP2/CharacterBody2D.moveTo(Vector2(positioAccordingBar,0))
		moveBirraP2 = true
		birraP2PosicioCorrecte = true
		
	if event.is_action_pressed("p1_press_button") and readyP1 == true && finishGame == false:
		$TimerP1.stop()
		$textProgressP1.text = str(numberprogressP1)+" %"
		var divit100 = float(numberprogressP1)/100
		print(divit100)
		var result = divit100*82
		print(result)
		var tantperCentPosition = result+208
				
		var birraposition = $BirrasP1/CharacterBody2D.position.x
		var positioAccordingBar = float(numberprogressP1)*94/100
		var ab = birraposition + positioAccordingBar
		$BirrasP1/CharacterBody2D.checkposition = true
		$BirrasP1/CharacterBody2D.direction = "left"
		$BirrasP1/CharacterBody2D/AnimatedSprite2D.play("default")
		$BirrasP1/CharacterBody2D.moveTo(Vector2(-numberprogressP1,0))
		birraP1PosicioCorrecte = true
		moveBirraP1 = true
 
func _on_timer_timeout():
	if sumaP2 == false:
		$HealthBarP2.emit_signal("update_health", $HealthBarP2.value - 5)
		numberprogressP2 = numberprogressP2 - 5
		if numberprogressP2 <= 1:
			sumaP2 = true
	else:
		$HealthBarP2.emit_signal("update_health", $HealthBarP2.value + 5)
		numberprogressP2 = numberprogressP2 + 5
		if numberprogressP2 >= 100:
			sumaP2 = false 	
	pass # Replace with function body.

func _on_timer_p_1_timeout():
	if sumaP1 == false:
		$HealthBarP1.emit_signal("update_health", $HealthBarP1.value - 5)
		numberprogressP1 = numberprogressP1 - 5
		if numberprogressP1 <= 1:
			sumaP1 = true
	else:
		$HealthBarP1.emit_signal("update_health", $HealthBarP1.value + 5)
		numberprogressP1 = numberprogressP1 + 5
		if numberprogressP1 >= 100:
			sumaP1 = false 	
	pass # Replace with function body.


func _on_si_touch_pressed():
	Global.goto_scene("res://MiniGames/TiralaBirra.tscn")
	pass # Replace with function body.


func _on_no_touch_pressed():
	Global.goto_scene("res://MainMenu/Jocs.tscn")
	pass # Replace with function body.


func _on_timer_goto_records_timeout() -> void:

	if await Global.ShouldAddScore():
		Global.goto_SaveRecords()
	else:
		Global.goto_Jocs()
	pass # Replace with function body.
