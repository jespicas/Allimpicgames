extends Node

var current_scene = null
var players = null
var tipusdeJoc = null
var hasConnection = null
var numPlayers = null
var currentGame = null
var listNick = null
var currentNick = null
var nickCompetir = null

var listPendingGames = null
var listPendingGamesToYou = null
var listPlayedGames = null
var scoreNickCompetir = null
var playWithYou = null

var pathSave="user://settings.json"
var pathFriendsList = "user://friends.json"
var pathScores = "user://scores.json"
var pathPartiesPendingToPlay = "user://pendings.json"

var keymapsFile = "user://keymaps.dat"
var defaultKeymapFile = "res://keymaps.dat"
var keymaps: Dictionary

var score = 0
#var urlApi = "https://allimpicgames-api-dev.azurewebsites.net/"
var urlApi = "http://localhost:5267/"

func goto_Records():
	Global.goto_scene("res://OtherOptions/ShowRecords.tscn")
	pass
func goto_Main():
	Global.goto_scene("res://MainMenu/MainMenu.tscn")
	pass
	
func setPlayWithYou(contratu):
	playWithYou = contratu
	
func setNickCompetir(nickAdversary):
	nickCompetir = nickAdversary
		
func setCurrentGame(game):
	currentGame = game
	
func setNumPlayers(num):
	numPlayers = num
	
func setPlayers(player):
	players = player
	
func setTipusJoc(tipus):
	tipusdeJoc = tipus

func setHasConnection(has):
	hasConnection = has
	
func _http_request_GetNick_completed(result, response_code, headers, body):
	var json = JSON.new()
	var a = body.get_string_from_utf8()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listNick = response
		print("Has Nicks")
	# Called when the node enters the scene tree for the first time.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		#print(response.headers["User-Agent"])	
		print("connected")
		hasConnection = true
		setHasConnection(true)
	else:
		hasConnection = false
		setHasConnection(false)
	
	# Called when the node enters the scene tree for the first time.
func _http_request_add_nick_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		#print(response.headers["User-Agent"])	
		print("Nick Add OK")
		#hasConnection = true
	else:
		print("Nick Failed")
		#hasConnection = false
	# Called when the node enters the scene tree for the first time.	
	pass
func _http_request_add_GameToApi_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		print(response["status"])
		#print(response.headers["User-Agent"])	
		
		#hasConnection = true
	else:
		print("Add score failed")
		#hasConnection = false
	# Called when the node enters the scene tree for the first time.	
	pass	
func _http_request_get_PendingGames_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPendingGames = response
		#print(response)
		#print(response.headers["User-Agent"])	
		
		#hasConnection = true
	else:
		print("Get pending games fails")
		#hasConnection = false
	# Called when the node enters the scene tree for the first time.	
	pass		
func _http_request_get_PendingGamesToYou_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPendingGamesToYou = response
	else:
		print("Get pending games fails")
	pass
func _http_request_get_PlayedGames_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPlayedGames = response
	else:
		print("Get pending games fails")
	pass
	
func sha_256(str: String) -> String:
	return str.sha256_text()

func getId() -> String:
	var os = OS.get_name()
	var processor = OS.get_processor_name()
	var unique = OS.get_unique_id()
	var osversion = OS.get_version()
	var dateTime = Time.get_datetime_dict_from_system()	
	return 	str(os)+str(processor)+str(unique)+str(osversion)+str(dateTime)

func checkHasConnection():
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
		
	var error = http_request.request(urlApi+"Status")
	await http_request.request_completed

	if error != OK:
		hasConnection = false
		push_error("An error occurred in the HTTP request.")

func save_keymap() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file := FileAccess.open(keymapsFile, FileAccess.WRITE)
	var fileDefault = FileAccess.open(defaultKeymapFile, FileAccess.READ)
	keymaps = fileDefault.get_var(true) as Dictionary
	file.store_var(keymaps, true)
	file.close()
	fileDefault.close()

func load_keymap() -> void:
	if not FileAccess.file_exists(keymapsFile):
		save_keymap() # There is no save file yet, so let's create one.
		return
	print("loadKEyMap")
	var file = FileAccess.open(keymapsFile, FileAccess.READ)
	var keymaps = file.get_var(true) as Dictionary
	
	file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
	for action in keymaps.keys():
	#	if temp_keymap.has(action):
	#		keymaps[action] = temp_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keymaps[action])
		print(action)

func _ready():
	
	#if existsKeyMapsUser() == false:
	#	for action in InputMap.get_actions():
	#		if InputMap.action_get_events(action).size() != 0:
	#			keymaps[action] = InputMap.action_get_events(action)[0]
	#	save_keymap()
	#else:
	#	load_keymap()
		
	checkHasConnection()
	
	if fileExists() == true:
		print("exists")
		var settings = GetSettings()
		currentNick = settings.nick
		if hasConnection == true:
			var http_request = HTTPRequest.new()	
			var json = JSON.stringify({ "Nick": settings.nick,  "IdApp": settings.unique_identifier,  "Os": OS.get_name(), "Info": "OpenAppWithSettings"})
			var headers = ["Content-Type: application/json"]
			var result = http_request.request(urlApi+"OlimpicAlls/connected", headers, HTTPClient.METHOD_POST, json)
			await http_request.request_completed
		#SaveNick("_espi_")
		pass
	else:
		var uniqueId = sha_256(getId())
		print( uniqueId)
		var file = FileAccess.open(pathSave, FileAccess.WRITE)
		var data = {
		"unique_identifier": uniqueId,
		"nick": "",
		}
		file.store_string(JSON.stringify(data))
		file.close()
		if hasConnection == true:
			goto_scene("res://MainMenu/Settings.tscn")
			UpdateSettings("FirstTimeApp")
		elif hasConnection == false:
			print("false")
		# TE INTERNET?
		# SI TE INTERNET ves a nick
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	print(current_scene)
	print("Global ready")
	pass # Replace with function body.

func SaveNick(nick):
	
	var file = FileAccess.open(pathSave, FileAccess.READ_WRITE)
	var json = JSON.new()
	var a = file.get_file_as_string(pathSave)	
	var dataOriginal = json.parse_string(a)
	file.close()
	
	var fileToSave = FileAccess.open(pathSave, FileAccess.WRITE)
	var data = {
	"unique_identifier": dataOriginal.unique_identifier,
	"nick": nick,
	}
	fileToSave.store_string(JSON.stringify(data))
	fileToSave.close()
	
	UpdateSettings("SavedNick")
	var shouldbeUpdate = false
	if listNick != null:
		#Get LAst nicks
		listNick = await GetAllNickRegistered()
		for nickfromApi in listNick:
			if dataOriginal.unique_identifier == nickfromApi.idApp:
				shouldbeUpdate = true
				#should be update
		if 	shouldbeUpdate == true:
			UpdateNickToApi(nick,dataOriginal.unique_identifier)
		else:
			AddNickToApi(nick,dataOriginal.unique_identifier)
	print(listNick)

func GetFriends():
	if FileAccess.file_exists(pathFriendsList) == true: 
		var file = FileAccess.open(pathFriendsList, FileAccess.READ_WRITE)
		var json = JSON.new()
		var a = file.get_file_as_string(pathFriendsList)	
		var data = json.parse_string(a)
		
		return data
	else:
		return null	
func AddFriends(nick):
	if FileAccess.file_exists(pathFriendsList) == true:
		var file = FileAccess.open(pathFriendsList, FileAccess.WRITE)
		#var emptyArray = []
		#var json = JSON.new()
		#var a = file.get_file_as_string(pathFriendsList)	
		#var data = json.parse_string(a)	
		#data.append(nick)	
		#file.store_string(JSON.stringify(emptyArray))
		#file.close()
		
		#file = FileAccess.open(pathFriendsList, FileAccess.READ_WRITE)
		file.store_string(JSON.stringify(nick))
		file.close()
		pass
	else:
		var file = FileAccess.open(pathFriendsList, FileAccess.WRITE)
		#var data = [nick]
		file.store_string(JSON.stringify(nick))
		file.close()

func StoreGamePending(nick,game):
	var gamesPending = GetPlayedPendingFromFile()
	
	if gamesPending == null:
		gamesPending = []
	
	if ExistsGamePendingInSettings(nick, game) == false:	
		gamesPending.append({"Nick":nick,"Game": game})	
		var fileToSave = FileAccess.open(pathPartiesPendingToPlay, FileAccess.WRITE)
		fileToSave.store_string(JSON.stringify(gamesPending))
		fileToSave.close()

func ExistsGamePendingInSettings(nick,game ):
	var gamesPending = GetPlayedPendingFromFile()
	var exists = false
	if gamesPending == null:
		return exists
	else:
		for gamePending in gamesPending:
			if gamePending.Nick == nick and gamePending.Game == game:
				exists = true
		return exists
			
func GetPlayedPendingFromFile():
	if FileAccess.file_exists(pathPartiesPendingToPlay):
		var file = FileAccess.open(pathPartiesPendingToPlay, FileAccess.READ_WRITE)
		var json = JSON.new()
		var a = file.get_file_as_string(pathPartiesPendingToPlay)	
		var data = json.parse_string(a)
	
		return data
	pass		

func GetScores():
	if FileAccess.file_exists(pathScores):
		var file = FileAccess.open(pathScores, FileAccess.READ_WRITE)
		var json = JSON.new()
		var a = file.get_file_as_string(pathScores)	
		var data = json.parse_string(a)
	
		return data
	pass		
	
func GetSettings():
	var file = FileAccess.open(pathSave, FileAccess.READ_WRITE)
	var json = JSON.new()
	var a = file.get_file_as_string(pathSave)	
	var data = json.parse_string(a)
	
	return data

func GetCurrentNick():
	return currentNick
	
func GetAllNickRegistered():
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_GetNick_completed)	
	if hasConnection == true:
		var headers = ["Content-Type: application/json"]
		var result = http_request.request(urlApi+"OlimpicAlls/getNicks", headers, HTTPClient.METHOD_GET)
		await http_request.request_completed
		return listNick
		#print(listNick)

func AddNickToApi(nick, uniqueIdentifier):
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_add_nick_completed)

	var json = JSON.stringify({ "NickName": nick,  "IdApp": uniqueIdentifier})
	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/addNick", headers, HTTPClient.METHOD_POST, json)
	await http_request.request_completed
	pass
	
func UpdateNickToApi(nick, uniqueIdentifier):
	print("update")
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_add_nick_completed)

	var json = JSON.stringify({ "NickName": nick,  "IdApp": uniqueIdentifier})
	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/updatenick", headers, HTTPClient.METHOD_PATCH, json)
	await http_request.request_completed
	pass	
func UpdateSettings(info):
	var settings = GetSettings()
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)	
	if hasConnection == true:
		var nick = "empty"
		if settings.nick != null:
			nick = settings.nick
		var json = JSON.stringify({ "Nick": nick,  "IdApp": settings.unique_identifier,  "Os": OS.get_name(), "Info": info})
		var headers = ["Content-Type: application/json"]
		var result = http_request.request(urlApi+"OlimpicAlls/connected", headers, HTTPClient.METHOD_POST, json)
		await http_request.request_completed		

func AddGameToApi(score):

	print( currentNick + " " + str(score) + " " + currentGame + " vs:" + nickCompetir + " Temps:"  + str(scoreNickCompetir))
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_add_GameToApi_completed)

	var json = JSON.stringify({ "Nick": currentNick,  "Score": score, "GameName": currentGame, "Played": false, "NickToPlay": nickCompetir, "ScorePlay": 0})
	if playWithYou == true:
		json = JSON.stringify({ "Nick": nickCompetir,  "Score": scoreNickCompetir, "GameName": currentGame, "Played": true, "NickToPlay": currentNick, "ScorePlay": score})
	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/addGameScore", headers, HTTPClient.METHOD_POST, json)
	await http_request.request_completed

	pass
	
	#{ "Nick": "_ESPID_","Score": 11.0101010, "GameName": "AgafaAlls", "Played": false, "NickToPlay": "Espi", "ScorePlay": 10 }

## Jo he demanat competir contra algu 
func GetPendingGames():
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_get_PendingGames_completed)

	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/getGamePending?nick="+currentNick+"&gameName="+currentGame, headers, HTTPClient.METHOD_GET)
	await http_request.request_completed
	return listPendingGames
	pass

## Han demanat competir contra mi
func GetPendingGamesToYou():
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_get_PendingGamesToYou_completed)

	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/GetGamePendingToYou?nick="+currentNick+"&gameName="+currentGame, headers, HTTPClient.METHOD_GET)
	await http_request.request_completed
	return listPendingGamesToYou
	pass

func RemovePendingGameFromFile(nick,game):
	var currentPending = GetPlayedPendingFromFile()
	var pos = 0
	var posFind = 0
	for pending in currentPending:
		if pending.Nick == nick and pending.Game == game:
			posFind = pos
		pos = pos + 1
		
	currentPending.remove_at(posFind)
	
	var fileToSave = FileAccess.open(pathPartiesPendingToPlay, FileAccess.WRITE)
	fileToSave.store_string(JSON.stringify(currentPending))
	fileToSave.close()
	
		
	pass
func ExistsScore(player1,score1,player2,score2,game):
	var scoresContent = GetScores()
	var exists = false
	if scoresContent != null:
		for scoreContent in scoresContent["Scores"]:
			if scoreContent.Player1 == player1 and scoreContent.ScoreP1 == score1 and scoreContent.Player2 == player2 and scoreContent.ScoreP2 == score2 and scoreContent.Game == game:
				exists = true 
	return exists

func StoreScores(player1,score1,player2,score2,game):
	var scoresContent = GetScores()
	var scores = []	
	if scoresContent != null:
		scores = scoresContent["Scores"]
		
	if ExistsScore(player1,score1,player2,score2,game) == false:	
		var scoreLine = { "Player1": player1, "ScoreP1": score1, "Player2": player2, "ScoreP2":score2, "Game": game, }
		scores.append(scoreLine)	
		var fileToSave = FileAccess.open(pathScores, FileAccess.WRITE)
		var scoresValues = { "Scores": scores}
		fileToSave.store_string(JSON.stringify(scoresValues))
		fileToSave.close()	
	pass
	
func GetPlayedGames():
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_get_PlayedGames_completed)

	var headers = ["Content-Type: application/json"]
	var result = http_request.request(urlApi+"OlimpicAlls/getGamePlayed?nick="+currentNick, headers, HTTPClient.METHOD_GET)
	await http_request.request_completed
	return listPlayedGames
	pass
		
func fileExists():
	var exists = false
	exists = FileAccess.file_exists(pathSave)
	return exists

func existsKeyMapsUser():
	var exists = false
	exists = FileAccess.file_exists(keymapsFile)
	return exists
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	print(current_scene)
	if is_instance_valid(current_scene):
		current_scene.free()
	
	var s = ResourceLoader.load(path)
	print(path)
	current_scene = s.instantiate()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)		
