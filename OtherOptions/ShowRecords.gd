extends CanvasLayer

var time = 3 


func _ready():
	var save_data = Global.GetScores()
	save_data = [{
	"score": 0,
	"name": "NAME",
	"game": "JOC"
	}]
	var new = {
		"score": 0,
		"name": "NAME",
		"game": "JOC"
	}
	new["name"] = "labels"
	new["score"] = int(100)
	new["game"] = "RecollirAlls"
	save_data.append(new)	
	#var json = JSON.new()
	#save_data = JSON.stringify(save_data)
	#var f := File.new()
	#var doFileExists = FileAccess.file_exists(Global.pathScores) #: f.file_exists("user://save.cfg")
	if save_data != null :
		
		#save_data.sort_custom(self, "customComparison")

		for i in range(save_data.size()):
			if i <= 5:
				var dynamic_font = FontVariation.new()
				dynamic_font.base_font = load("res://Media/Fonts/zero_cool/ZeroCool.ttf")
				#dynamic_font. = 16
				#dynamic_font.outline_size = 1
				#dynamic_font.outline_color = Color( 1, 1, 1, 1 )
				#dynamic_font.use_filter = true			
				var hola = Label.new()
				print(save_data[i]["name"])
				hola.text = save_data[i]["name"]
				
				hola.visible = true
				#hola.add_font_override()
				#hola.add_font_override("font", dynamic_font)
				#hola.add_color_override("font_color", Color(0, 0, 0, 1))
				#hola.add_color_override("font_color", Color.red)
				var score = Label.new()
				#score.add_font_override("font", dynamic_font)
				#score.add_color_override("font_color", Color(0, 0, 0, 1))
				#score.add_color_override("font_color", Color(0, 0, 0, 1))
				score.text = str(save_data[i]["score"])
				score.visible = true
				$Control2/RecollirAlls.add_child(hola)
				$Control2/RecollirAlls.add_child(score)
	pass # Replace with function body.

func customComparison(a, b):
	if typeof(a.score) != typeof(b.score):
		return typeof(a.score) < typeof(b.score)
	else:
		return a.score > b.score

func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += " " + String(i)
	return s


func _on_Timer_timeout():
	time -= 1	
	if time <= 0:
		pass
		#Global.goto_Main()
