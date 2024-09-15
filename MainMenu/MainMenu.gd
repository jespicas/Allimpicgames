extends Node2D

var currentPosition = null

enum menupositions {PLAYER1, PLAYER2, REDEFINIR, INFO, PUNTUACIONS, INFO2}

var keymapsFile = "user://keymaps.dat"

var GetScores = null
var wrGetScores = null
var latest_max = 10

func existsKeyMapsUser():
	var exists = false
	exists = FileAccess.file_exists(keymapsFile)
	return exists
	
# Called when the node enters the scene tree for the first time.
func _ready():
	ReadyToCheckSilentWolf()
	#if existsKeyMapsUser() == false:
	#	Global.goto_scene("res://UI/RemappingKeys/RemappingKeys.tscn")
	#else:
	#	Global.load_keymap()
	#	pass
	$playerOne.grab_focus()
	currentPosition = menupositions.PLAYER1
	#ShowHideOthers(false)
	#CheckGamesPending()
	
	# si no hi ha nick i te internet
	# anar a la pagina d' entrar el nick
	pass # Replace with function bod

func ReadyToCheckSilentWolf():
	var prepared_http_req = SilentWolf.prepare_http_request()
	GetScores = prepared_http_req.request
	wrGetScores = prepared_http_req.weakref
	GetScores.request_completed.connect(_on_GetScores_request_completed)
	#SWLogger.info("Calling SilentWolf backend to get scores...")
	# resetting the latest_number value in case the first requests times out, we need to request the same amount of top scores in the retry
	latest_max = 10
	#var request_url = "https://api.silentwolf.com/get_scores/" + str(SilentWolf.config.game_id) + "?max=" + str(10)  + "&ldboard_name=" + str("main") 
	var request_url = "https://api.silentwolf.com/"
	SilentWolf.send_get_request(GetScores, request_url)
		
func _on_GetScores_request_completed(result, response_code, headers, body) -> void:
	var status_check = SilentWolf.SWUtils.check_http_response(response_code, headers, body)
	SilentWolf.free_request(wrGetScores, GetScores)
	print("status")
	print(status_check)
	if status_check:
		Global.set_SilentWolfWorks(true)
	else:
		Global.set_SilentWolfWorks(false)
	
func checkedconnection():
	pass

func CheckGamesPending():
	await Global.checkHasConnection()
	print(Global.hasConnection)
	if Global.hasConnection	== true:
		var listPlayedGames = await Global.GetPlayedGames()
		var listGamesToBePlay = Global.GetPlayedPendingFromFile()
		var listScores = Global.GetScores()
		
		#despres de posar scores borrar pending
		for game in listPlayedGames:
			if Global.ExistsGamePendingInSettings(game.nickToPlay,"AgafaAlls"):
				if game.nick == Global.currentNick:
					var exists = Global.ExistsScore(game.nick,game.score, game.nickToPlay,game.scorePlay,"AgafaAlls")
					if exists == false:
						Global.StoreScores(game.nick,game.score, game.nickToPlay,game.scorePlay,"AgafaAlls")
						Global.RemovePendingGameFromFile(game.nickToPlay,"AgafaAlls")
						$ListPlayedGames.show()	
						$ListPlayedGames/ItemList.add_item(game.nickToPlay)
						$ListPlayedGames/ItemList.add_item(str(game.scorePlay))
						if game.score < game.scorePlay:
							$ListPlayedGames/ItemList.add_item("Si")
						else:
							$ListPlayedGames/ItemList.add_item("No")
						$ListPlayedGames/ItemList.add_item("AgafaAlls")
						currentPosition = menupositions.INFO
					pass
			if Global.ExistsGamePendingInSettings(game.nick,"AgafaAlls"):
				if game.nickToPlay == Global.currentNick:
					var exists = Global.ExistsScore(game.nickToPlay,game.scorePlay, game.nick,game.score,"AgafaAlls")
					if exists == false:
						Global.StoreScores(game.nickToPlay,game.scorePlay, game.nick,game.score,"AgafaAlls")				
						$ListPlayedGames.show()	
						$ListPlayedGames/ItemList.add_item(game.nick)
						$ListPlayedGames/ItemList.add_item(str(game.score))
						if game.score > game.scorePlay:
							$ListPlayedGames/ItemList.add_item("No")
						else:
							$ListPlayedGames/ItemList.add_item("Si")
						$ListPlayedGames/ItemList.add_item("AgafaAlls")
						currentPosition = menupositions.INFO
					pass
			#Exists in Score? -> nothing
			
			#is Pending from GamesToBePlay ? -> shown and add to score
			# If not exists in score and not in pending from games to be play
			# add in score 
			
			pass
		
		
		#$ListPlayedGames.show()	
		#$ListPlayedGames/ItemList.add_item("espi")
		#$ListPlayedGames/ItemList.add_item("10.0101")
		#$ListPlayedGames/ItemList.add_item("Si")
		#$ListPlayedGames/ItemList.add_item("AgafaAlls")
		
		#$ListPlayedGames/ItemList.add_item("_espi_")
		#$ListPlayedGames/ItemList.add_item("11.0101")
		#$ListPlayedGames/ItemList.add_item("No")
		#$ListPlayedGames/ItemList.add_item("AgafaAlls")
	
#func ShowHideOthers(show):
#	$practicar.visible = show
#	$practicarTouch.visible = show
#	$competir.visible = show
#	$competir.visible = show
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func buttonPlayer1Pressed():
	Global.setPlayers("player1")
	$"playerTwo".hide()
	$"2playertouch".visible = false
	#ShowHideOthers(true)
	$focusAll.position.y = 190
#	currentPosition = menupositions.COMPETIR	
	Global.setNumPlayers(1)
	if Global.hasConnection == false:
		$competir.hide()
		$allimpictouch.hide()
#		currentPosition = menupositions.PRACTICAR
		$focusAll.position.x = 165	
#	print("player1")
	
func buttonPlayer2Pressed():
	Global.setPlayers("player2")		
	$"playerOne".hide()
	$"1playertouch".visible = false
	#ShowHideOthers(true)	
	$focusAll.position.y = 190
	$focusAll.position.x = 43
#	currentPosition = menupositions.COMPETIR
	Global.setNumPlayers(2)
	#buttonCompetirPressed()	
	print("player2")
	
func buttonSettingsPressed():
	Global.goto_scene("res://MainMenu/Settings.tscn")


func _on_TouchScreenButton_pressed(extra_arg_0):
	if extra_arg_0 == "btnSettings":
		buttonSettingsPressed()
	if extra_arg_0 == "btnPlayer1":
		buttonPlayer1Pressed()
	if extra_arg_0 == "btnPlayer2":
		buttonPlayer2Pressed()
	if extra_arg_0 == "btnDacord":
		$ListPlayedGames.hide()		
	pass # Replace with function body.
func HidePlayedGames():
	$ListPlayedGames.hide()
	currentPosition = menupositions.PLAYER1
	$focusAll.position.x = 43	
	
func _input(event):
	#print(event.is_action_released())
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		print(currentPosition)
		if currentPosition == menupositions.PLAYER1:
			Global.setPlayers("player1")
			Global.setNumPlayers(1)
			Global.goto_scene("res://MainMenu/Jocs.tscn")
		elif currentPosition == menupositions.PLAYER2:
			Global.setPlayers("player2")
			Global.setNumPlayers(2)
			Global.goto_scene("res://MainMenu/Jocs.tscn")
			#buttonPlayer2Pressed()
		elif currentPosition == menupositions.PUNTUACIONS:
			Global.goto_Records()
		elif currentPosition == menupositions.INFO:
			Global.goto_scene("res://Instruccions/JocsInstruccions.tscn")
		#elif currentPosition == menupositions.SHOWNGAMES:
		#	HidePlayedGames()
		print("enter")
	if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left"):
		print("left")
		if currentPosition == menupositions.PLAYER2:
			currentPosition = menupositions.PLAYER1
			$focusAll.position.x = 43	
		elif currentPosition == menupositions.INFO:
			currentPosition = menupositions.REDEFINIR
			$focusAll.position.x = 43
			if Global.hasConnection == false && Global.numPlayers == 1:
				currentPosition = menupositions.INFO
				$focusAll.position.x = 165
		elif currentPosition == menupositions.REDEFINIR:
			currentPosition = menupositions.INFO
			$focusAll.position.x = 43
		#	$focusAll.position.x = 43#elif currentPosition == menupositions.INFO:
		#	HidePlayedGames()

			pass
	if event.is_action_pressed("p1_move_down") or event.is_action_pressed("p2_move_down"):
#		print("down")
		if currentPosition == menupositions.INFO or currentPosition == menupositions.REDEFINIR:
			currentPosition = menupositions.PUNTUACIONS
			$focusAll.position.x = 43
			$focusAll.position.y = 220
		if currentPosition == menupositions.PLAYER1 or currentPosition == menupositions.PLAYER2:
			currentPosition = menupositions.INFO
			$focusAll.position.x = 43
			$focusAll.position.y = 190
			pass

			
	if event.is_action_pressed("p1_move_up") or event.is_action_pressed("p2_move_up"):
		if currentPosition == menupositions.INFO  or currentPosition == menupositions.REDEFINIR:
			currentPosition = menupositions.PLAYER1
			$focusAll.position.x = 43
			$focusAll.position.y = 161	
			Global.setNumPlayers(null)
			Global.setPlayers(null)
		
		if currentPosition == menupositions.PUNTUACIONS:
			currentPosition = menupositions.INFO
			$focusAll.position.x = 43
			$focusAll.position.y = 190	
			Global.setNumPlayers(null)
			Global.setPlayers(null)

		pass
	if event.is_action_pressed("p1_move_right") or event.is_action_pressed("p2_move_right"):
		if currentPosition == menupositions.PLAYER1:
			currentPosition = menupositions.PLAYER2
			$focusAll.position.x = 165
		elif currentPosition == menupositions.REDEFINIR:
			currentPosition = menupositions.INFO
			$focusAll.position.x = 165
			pass
		elif currentPosition == menupositions.INFO:
			currentPosition = menupositions.REDEFINIR
			$focusAll.position.x = 165
			
			
			#MoveToBack()
		print("right")
