extends CanvasLayer

var time = 3 

var agafaAll = "AgafaAlls";
var tiralabirra = "TiralaBirra";
var tirall = "Tirall";
var concursallioli = "ConcursAlliOli";
var enforcaralls = "EnforcarAlls";

func _ready():
	var save_data = Global.GetScores()
	save_data = [{
	"score": 33,
	"name": "PEP",
	"game": "TiralaBirra"
	}]
	var new = {
		"score": 0,
		"name": "DET",
		"game": "AgafaAlls"
	}
	save_data.append(new)
	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)	
	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)	
	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)	
	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)			

	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)	
	new = {
		"score": 0,
		"name": "MTR",
		"game": "AgafaAlls"
	}
	save_data.append(new)				
	new = {
		"score": 100,
		"name": "KNZ",
		"game": "TiralaBirra"
	}
	save_data.append(new)
	new = {
		"score": 140,
		"name": "JEC",
		"game": "Tirall"
	}
	save_data.append(new)
	new = {
		"score": 140,
		"name": "JEC",
		"game": "Tirall"
	}
	save_data.append(new)	
	new = {
		"score": 130,
		"name": "SEC",
		"game": "Tirall"
	}
	save_data.append(new)	
	new = {
		"score": 240,
		"name": "PEC",
		"game": "Tirall"
	}
	save_data.append(new)	
	new = {
		"score": 110,
		"name": "JEC",
		"game": "Tirall"
	}
	save_data.append(new)	
	new = {
		"score": 120,
		"name": "LEC",
		"game": "Tirall"
	}
	save_data.append(new)	
	new = {
		"score": 130,
		"name": "JEC",
		"game": "Tirall"
	}
	save_data.append(new)	

	new = {
		"score": 140,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
	new = {
		"score": 180,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		
	new = {
		"score": 110,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		
	new = {
		"score": 140,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		
	new = {
		"score": 150,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		
	new = {
		"score": 140,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		
	new = {
		"score": 140,
		"name": "JEC",
		"game": "ConcursAlliOli"
	}
	save_data.append(new)
		

	new = {
		"score": 90,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	new = {
		"score": 120,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	new = {
		"score": 110,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	new = {
		"score": 230,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	new = {
		"score": 120,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	new = {
		"score": 220,
		"name": "DEC",
		"game": "EnforcarAlls"
	}
	save_data.append(new)
	#var json = JSON.new()
	#save_data = JSON.stringify(save_data)
	#var f := File.new()
	#var doFileExists = FileAccess.file_exists(Global.pathScores) #: f.file_exists("user://save.cfg")
	if save_data != null :
		
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

func fillGrid(gridName,values):
	if values.size()> 0:
		#values.sort_custom(self, "customComparison")
		values.sort_custom(func(a, b): return a["score"] > b["score"])
		for i in range(values.size()):
			if i <= 4:
				var dynamic_font = FontVariation.new()
				dynamic_font.base_font = load("res://Media/Fonts/zero_cool/ZeroCool.ttf")
				dynamic_font.set_spacing(TextServer.SPACING_BOTTOM,-5	)
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
					$Control2/RecollirAlls.add_child(name)
					$Control2/RecollirAlls.add_child(score)
				if gridName == tiralabirra:
					$Control2/TirarBirrall.add_child(name)
					$Control2/TirarBirrall.add_child(score)
				if gridName == tirall:
					$Control2/TirAll.add_child(name)
					$Control2/TirAll.add_child(score)				
				if gridName == concursallioli:
					$Control2/Allioli.add_child(name)
					$Control2/Allioli.add_child(score)				
				if gridName == enforcaralls:
					$Control2/EnforArlls.add_child(name)
					$Control2/EnforArlls.add_child(score)				
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
