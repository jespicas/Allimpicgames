extends CanvasLayer

var time = 3 

var agafaAll = "AgafaAlls";
var tiralabirra = "TiralaBirra";
var tirall = "Tirall";
var concursallioli = "ConcursAlliOli";
var enforcaralls = "EnforcarAlls";

func _ready():

	var save_data = Global.GetScores()

	#var json = JSON.new()
	#save_data = JSON.stringify(save_data)
	#var f := File.new()
	#var doFileExists = FileAccess.file_exists(Global.pathScores) #: f.file_exists("user://save.cfg")
	if save_data != null :
		
		if Global.silentWolfWorks:	
			var recollirAllsRecords = await GetRecordsFromSilentWolf("agafaalls") # GetRecordsFromGame(agafaAll,save_data)
			fillGrid(agafaAll,recollirAllsRecords)
			var tirabirrallRecords = await GetRecordsFromSilentWolf("tiralabirra") #GetRecordsFromGame(tiralabirra,save_data)
			fillGrid(tiralabirra,tirabirrallRecords)
			var tirallRecords = await GetRecordsFromSilentWolf("tirall") #GetRecordsFromGame(tirall,save_data)
			fillGrid(tirall,tirallRecords)
			var allioliRecords = await GetRecordsFromSilentWolf("allioli") #GetRecordsFromGame(concursallioli,save_data)
			fillGrid(concursallioli,allioliRecords)			
			var enforcarAllsRecords = await GetRecordsFromSilentWolf("enforcaralls") #GetRecordsFromGame(enforcaralls,save_data)
			fillGrid(enforcaralls,enforcarAllsRecords)
		else:
			
			var recollirAllsRecords = GetRecordsFromGame(agafaAll,save_data)
			var tirabirrallRecords = GetRecordsFromGame(tiralabirra,save_data)
			var tirallRecords = GetRecordsFromGame(tirall,save_data)
			var allioliRecords = GetRecordsFromGame(concursallioli,save_data)
			var enforcarAllsRecords = GetRecordsFromGame(enforcaralls,save_data)
			fillGrid(agafaAll,recollirAllsRecords)
			fillGrid(tiralabirra,tirabirrallRecords)
			fillGrid(tirall,tirallRecords)
			fillGrid(concursallioli,allioliRecords)
			fillGrid(enforcaralls,enforcarAllsRecords)
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("exit"):
		Global.goto_Main()
	
func fillGrid(gridName,values):
	if values.size()> 0:
		#values.sort_custom(self, "customComparison")
		if gridName == agafaAll or gridName == enforcaralls:
			values.sort_custom(func(a, b): return str(a["score"]).to_float() < str(b["score"]).to_float())
		else:
			values.sort_custom(func(a, b): return str(a["score"]).to_float() > str(b["score"]).to_float())
		for i in range(values.size()):
			if i <= 4:
				var dynamic_font = FontVariation.new()
				dynamic_font.base_font = load("res://Media/Fonts/zero_cool/ZeroCool.ttf")
				dynamic_font.set_spacing(TextServer.SPACING_BOTTOM,-5	)
				var pos = Label.new()
				pos.add_theme_font_override("font",dynamic_font)
				pos.add_theme_font_size_override("font_size",8)
				pos.add_theme_color_override("font_color", Color(0,0,0,1))
				pos.text = str(i+1)+"."
				pos.visible = true				
				var name = Label.new()
				name.add_theme_font_override("font",dynamic_font)
				name.add_theme_font_size_override("font_size",8)
				name.add_theme_color_override("font_color", Color(0,0,0,1))
				name.text = values[i]["name"]
				name.visible = true
				var score = Label.new()
				
				score.add_theme_font_override("font",dynamic_font)
				score.add_theme_font_size_override("font_size",8)
				score.add_theme_color_override("font_color", Color(0,0,0,1))

				score.text = str(values[i]["score"])
				score.visible = true
				if gridName == agafaAll:
					$Control2/RecollirAllGroup/RecollirAlls.add_child(pos)
					$Control2/RecollirAllGroup/RecollirAlls.add_child(name)
					$Control2/RecollirAllGroup/RecollirAlls.add_child(score)
				if gridName == tiralabirra:
					$Control2/TiraBirraGroup/TirarBirrall.add_child(pos)
					$Control2/TiraBirraGroup/TirarBirrall.add_child(name)
					$Control2/TiraBirraGroup/TirarBirrall.add_child(score)
				if gridName == tirall:
					$Control2/TirAllGroup/TirAll.add_child(pos)
					$Control2/TirAllGroup/TirAll.add_child(name)
					$Control2/TirAllGroup/TirAll.add_child(score)				
				if gridName == concursallioli:
					$Control2/AllioliGroup/Allioli.add_child(pos)
					$Control2/AllioliGroup/Allioli.add_child(name)
					$Control2/AllioliGroup/Allioli.add_child(score)				
				if gridName == enforcaralls:
					$Control2/EnforcarAllsGroup/EnforArlls.add_child(pos)
					$Control2/EnforcarAllsGroup/EnforArlls.add_child(name)
					$Control2/EnforcarAllsGroup/EnforArlls.add_child(score)				
func customComparison(a, b):
	if typeof(a["score"]) != typeof(b["score"]):
		return typeof(a["score"]) < typeof(b["score"])
	else:
		return a["score"] > b["score"]

func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += " " + String(i)
	return s

func GetRecordsFromSilentWolf(leaderboard):
	var sw_result = await SilentWolf.Scores.get_scores(0, leaderboard).sw_get_scores_complete
	var scores = sw_result.scores
	print(scores)
	var new_game = []
	for score in scores:
		var gameRecord = {
			"score": score["score"],
			"name": score["player_name"]
		}
		new_game.append(gameRecord)
	return new_game
		
func GetRecordsFromGame(game, save_data):
	var new_game = []
	
	for line in save_data:
		if line["game"] == game:
			var gameRecord = {
				"score": line["score"],
				"name": line["name"]
			}
			new_game.append(gameRecord)
	return new_game
	
	
func _on_Timer_timeout():
	time -= 1	
	if time <= 0:
		Global.goto_Main()
