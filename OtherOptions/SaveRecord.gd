extends Node2D

var labels = ["_","_","_"]
var pos = 0
var labelsText = [
	$Control/Label,
	$Control/Label2,
	$Control/Label3
]
#var save_data = [{
#	"score": 0,
#	"name": "NAME",
#	"game": "JOC"
#}]

func _input(event):

	var posGrid = 0
	var posCurrentFocus = 0
	for i in $Control2/GridContainer.get_children():
		if i.has_focus():
			posCurrentFocus = posGrid			
		posGrid += 1	
	var is_up = false
	var	is_down = false
	var is_left = false
	var is_right = false
	if Input.is_action_pressed("p1_move_right") or Input.is_action_pressed("p2_move_right"):
		print("right")
		is_right = true		
	if Input.is_action_pressed("p1_move_left") or Input.is_action_pressed("p2_move_left"):
		is_left = true
		print("left")
	if Input.is_action_pressed("p1_move_up") or Input.is_action_pressed("p2_move_up"):
		is_up = true
		print("up")
	if Input.is_action_pressed("p1_move_down") or Input.is_action_pressed("p2_move_down"):
		is_down = true
		print("down")

	posGrid = 0
	if is_down == true or is_right == true:
		for i in $Control2/GridContainer.get_children():
			if (posGrid == posCurrentFocus):
				i.release_focus()
			if (posGrid == posCurrentFocus +1):
				i.grab_focus()
			posGrid +=1
	if is_up == true or is_left == true:
		print(posGrid)
		print(posCurrentFocus)
		for i in $Control2/GridContainer.get_children():
			if (posGrid == posCurrentFocus -1):
				i.grab_focus()
			if (posGrid == posCurrentFocus):
				i.release_focus()
			posGrid +=1
			#var posi = posCurrentFocus 
			#print(posi)
			#$Control2/GridContainer[posCurrentFocus+1].grab_focus()	
	else:
		if event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button") :
#			print(event.as_text())
			if event.is_pressed() == true:
				for i in $Control2/GridContainer.get_children():
					if i.has_focus():
						_button_pressed(i)


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $Control2/GridContainer.get_children():
		i.connect("pressed",Callable(self, "_button_pressed"))
		#i.connect("pressed", Callable(self, "_button_pressed", [i]))
	redrawName()
	
	var total = Global.score
	#Global.setCurrentGame("savereocrds")
	$Control/punts.text = str(total)
	$Control/nomjoc.text = Global.currentGame
	$Control2/GridContainer/End.grab_focus()
	pass # Replace with function body.

func addLabel(value):
	if pos < 3:
		labels[pos] = value
	if pos +1 <= 3:
		pos = pos +1
	redrawName()
	if isFilled() == true:
		store()
		nextlevel()
	
func isFilled():
	var toReturn = false
	for i in 3:
		toReturn =  $Control.get_children()[i].text != "_"
			
	return toReturn

func redrawName():
	for i in 3:		
		$Control.get_children()[i].text = labels[i]

func removeLabel():
	if pos -1 >= 0:
		labels[pos-1] = "_"
		pos = pos -1 
		redrawName()
	else:
		print("remove")
#		for i in 2:
#			$Control.get_children()[i].text = labels[i]
func store():
	if fileExists() == true:
		var save_file = Global.GetScores()
		
		var new = {
			"score": Global.score,
			"name": labels[0]+labels[1]+labels[2],
			"game": Global.currentGame
		}		
		save_file.append(new)
		var save_fileOverride = FileAccess.open(Global.pathScores, FileAccess.WRITE)
		var json_string = JSON.stringify(save_file)
		save_fileOverride.store_line(json_string)		
		
	else:
		var new = [{
			"score": Global.score,
			"name": labels[0]+labels[1]+labels[2],
			"game": Global.currentGame
		}]
		var save_file = FileAccess.open(Global.pathScores, FileAccess.WRITE)
		var json_string = JSON.stringify(new)
		save_file.store_line(json_string)		


func fileExists():
	return FileAccess.file_exists(Global.pathScores)
	
func _button_pressed(button):
	print(button)
	if (button.text == "Del"):
		removeLabel()
	elif (button.text == "End"):
		store()
		nextlevel()
	else:
		addLabel(button.text)
func nextlevel():
	Global.goto_Records()
