extends CanvasLayer

var time = 3 

func _ready():
	var f := File.new()
	var doFileExists = f.file_exists("user://save.cfg")
	if doFileExists == true:
		f.open("user://save.cfg", File.READ)
		var text =  f.get_as_text()	
		var save_data = parse_json(text)
		f.close()

		save_data.sort_custom(self, "customComparison")

		for i in range(save_data.size()):
			if i <= 9:
				var dynamic_font = DynamicFont.new()
				dynamic_font.font_data = load("res://assets/fonts/Stacked pixel.ttf")
				dynamic_font.size = 16
				dynamic_font.outline_size = 1
				dynamic_font.outline_color = Color( 1, 1, 1, 1 )
				dynamic_font.use_filter = true			
				var hola = Label.new()
				hola.text = array_to_string(save_data[i].name)
				
				hola.visible = true
				#hola.add_font_override()
				hola.add_font_override("font", dynamic_font)
				hola.add_color_override("font_color", Color(0, 0, 0, 1))
				#hola.add_color_override("font_color", Color.red)
				var score = Label.new()
				score.add_font_override("font", dynamic_font)
				score.add_color_override("font_color", Color(0, 0, 0, 1))
				#score.add_color_override("font_color", Color(0, 0, 0, 1))
				score.text = str(save_data[i].score)
				score.visible = true
				$Control2/GridContainer.add_child(hola)
				$Control2/GridContainer.add_child(score)
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
		Global.goto_Main()
