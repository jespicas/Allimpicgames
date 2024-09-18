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
var defaultKeymapFile = "res://keymapsOrg.cfg"
var keymaps: Dictionary
var OriginalKeymaps: Dictionary

var agafaAll = "AgafaAlls";
var tiralabirra = "TiralaBirra";
var tirall = "Tirall";
var concursallioli = "ConcursAlliOli";
var enforcaralls = "EnforcarAlls";
var score = 0
#var urlApi = "https://allimpicgames-api-dev.azurewebsites.net/"
var urlApi = "http://localhost:5267/"

var silentWolfWorks = false

var globalEntered = 0

var enableRedefineKeys = false

func set_SilentWolfWorks(value):
	silentWolfWorks = value

func setScore(value):
	score = value
	
func goto_Records():
	Global.goto_scene("res://OtherOptions/ShowRecords.tscn")
	pass
func goto_SaveRecords():
	Global.goto_scene("res://OtherOptions/SaveRecord.tscn")
	pass	
func goto_Main():
	Global.goto_scene("res://MainMenu/MainMenu.tscn")
	pass
func goto_Jocs():
	currentGame = ""	
	Global.goto_scene("res://MainMenu/Jocs.tscn")
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
	# Called when the node enters the scene tree for the first time.
func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
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


	# Called when the node enters the scene tree for the first time.	
	pass
func _http_request_add_GameToApi_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	# Called when the node enters the scene tree for the first time.	
	pass	
func _http_request_get_PendingGames_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPendingGames = response
	# Called when the node enters the scene tree for the first time.	
	pass		
func _http_request_get_PendingGamesToYou_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPendingGamesToYou = response


	pass
func _http_request_get_PlayedGames_completed(result, response_code, header, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	if response != null:
		listPlayedGames = response
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

func storeCurrentProjectSettingsKeyMaps():
		var fileDefault = FileAccess.open(defaultKeymapFile, FileAccess.WRITE)
		for action in InputMap.get_actions():
			if InputMap.action_get_events(action).size() != 0:
				keymaps[action] = InputMap.action_get_events(action)		
		fileDefault.store_var(keymaps, true)
		fileDefault.close()
		
func save_keymap() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file := FileAccess.open(keymapsFile, FileAccess.WRITE)
	var fileDefault = FileAccess.open(defaultKeymapFile, FileAccess.READ)
	keymaps = fileDefault.get_var(true) as Dictionary
	file.store_var(keymaps, true)
	file.close()
	fileDefault.close()	


func load_keymap() -> void:
	if FileAccess.file_exists(defaultKeymapFile):
		var fileOriginal = FileAccess.open(defaultKeymapFile, FileAccess.READ)
		var OriginalKeymaps = fileOriginal.get_var(true) as Dictionary	
		fileOriginal.close()
		if FileAccess.file_exists(keymapsFile):
			var file = FileAccess.open(keymapsFile, FileAccess.READ)
			var keymaps = file.get_var(true) as Dictionary	
			file.close()
			for action in OriginalKeymaps.keys():
				var originalAction = InputMap.get(action)
				var b = keymaps.get(action)
				if b != null:
					InputMap.action_erase_events(action)
					for act in b:
						InputMap.action_add_event(action, act)
				else:
					InputMap.action_erase_events(action)
					for act in OriginalKeymaps[action]:
						InputMap.action_add_event(action, act)
		else:
			if not FileAccess.file_exists(keymapsFile):
				var file := FileAccess.open(keymapsFile, FileAccess.WRITE)
				file.store_var(OriginalKeymaps, true)
				file.close()
				return

func reset_keymap() -> void:
	var path = ProjectSettings.globalize_path(keymapsFile)
	DirAccess.remove_absolute(path)
	OS.move_to_trash(ProjectSettings.globalize_path(keymapsFile))
	
	if FileAccess.file_exists(keymapsFile):
		print("no borrat")
	load_keymap()
		
func _ready():
	globalEntered += 1
	load_keymap()
	print_debug("Global ready Entered "+str(globalEntered))
	
	if fileExists() == true:
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
	if Global.silentWolfWorks:
		return "SomethingtoContinue"
	else:
		if FileAccess.file_exists(pathScores):
			var file = FileAccess.open(pathScores, FileAccess.READ_WRITE)
			var json = JSON.new()
			var a = file.get_file_as_string(pathScores)	
			var data = json.parse_string(a)
		
			return data
	pass		

func ShouldAddScoreSilentWolf(leaderboard):
	var nameJoc = currentGame
	var scores = await GetRecordsFromSilentWolf(leaderboard)
	if scores.size() >= 5:
		if nameJoc == "AgafaAlls" or nameJoc == "EnforcarAlls":
			if str(scores[4]["score"]).to_float() < str(score).to_float():
				return false
			else:
				return true
		else:
			if str(scores[4]["score"]).to_float() > str(score).to_float():
				return false
			else:
				return true
	else:
		return true	
		
func ShouldAddScore():
	var nameJoc = currentGame
	if Global.silentWolfWorks:
		var silengame = ""
		if nameJoc == agafaAll:
			silengame = "agafaalls"
		if nameJoc == concursallioli:
			silengame = "allioli"
		if nameJoc == enforcaralls:
			silengame = "enforcaralls"
		if nameJoc == tiralabirra:
			silengame = "tiralabirra"
		if nameJoc == tirall:
			silengame = "tirall"				
		return await ShouldAddScoreSilentWolf(silengame)
	else:
		if FileAccess.file_exists(pathScores):
			var scores = GetScores()
			scores = GetRecordsFromGame(nameJoc,scores)
			if scores.size() >= 5:
				if nameJoc == agafaAll or nameJoc == enforcaralls:
					if str(scores[4]["score"]).to_float() < str(score).to_float():
						return false
					else:
						return true
				else:
					if str(scores[4]["score"]).to_float() > str(score).to_float():
						return false
					else:
						return true
			else:
				return true
		else:
			return true	
		
func GetRecordsFromGame(game, save_data):
	var new_game = []
	
	for line in save_data:
		if line["game"] == game:
			var gameRecord = {
				"score": line["score"],
				"name": line["name"]
			}
			new_game.append(gameRecord)

	if game == agafaAll or game == enforcaralls:
		new_game.sort_custom(func(a, b): return str(a["score"]).to_float() < str(b["score"]).to_float())
	else:
		new_game.sort_custom(func(a, b): return str(a["score"]).to_float() > str(b["score"]).to_float())			
	return new_game
	
func GetRecordsFromSilentWolf(leaderboard):
	var sw_result = await SilentWolf.Scores.get_scores(0, leaderboard).sw_get_scores_complete
	var scores = sw_result.scores
	var new_game = []
	for score in scores:
		var gameRecord = {
			"score": score["score"],
			"name": score["player_name"]
		}
		new_game.append(gameRecord)
		
	if leaderboard == agafaAll or leaderboard == enforcaralls:
		new_game.sort_custom(func(a, b): return str(a["score"]).to_float() < str(b["score"]).to_float())
	else:
		new_game.sort_custom(func(a, b): return str(a["score"]).to_float() > str(b["score"]).to_float())			
	return new_game		
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
	if is_instance_valid(current_scene):
		current_scene.free()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)		
