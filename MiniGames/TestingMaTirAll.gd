extends Node2D

var points = 0
var allposition 

var foratsValidsPosition = [
	{
		"name" = "forat1",
		"rangXmin" = 30,
		"rangXmax" = 68,
		"rangYmin" = 164,
		"rangYmax" = 190
	},
	{
		"name" = "forat2",
		"rangXmin" = 90,
		"rangXmax" = 129,
		"rangYmin" = 82,
		"rangYmax" = 100
	},
	{	
		"name" = "forat3",
		"rangXmin" = 150,
		"rangXmax" = 173,
		"rangYmin" = 55,
		"rangYmax" = 75
	},
	{
		"name" = "forat4",
		"rangXmin" = 140,
		"rangXmax" = 160,
		"rangYmin" = 130,
		"rangYmax" = 145
	},	
	{
		"name" = "forat5",
		"rangXmin" = 195,
		"rangXmax" = 225,
		"rangYmin" = 76,
		"rangYmax" = 100
	},
	{
		"name" = "forat6",
		"rangXmin" = 260,
		"rangXmax" = 290,
		"rangYmin" = 95,
		"rangYmax" = 120
	},
	{
		"name" = "forat7",
		"rangXmin" = 210,
		"rangXmax" = 246,
		"rangYmin" = 155,
		"rangYmax" = 180
	},
	{
		"name" = "forat8",
		"rangXmin" = 110,
		"rangXmax" = 140,
		"rangYmin" = 172,
		"rangYmax" = 200
	}
]
# Called when the node enters the scene tree for the first time.
func _ready():
	$MaTirAll.emit_signal("init")
	$MaTirAll/Allxoca.connect("entratForat", Callable(self,"entratForatAll"))
	#dispararMaEsDiana($Sprite2D.position)
	#print(foratsValidsPosition[0]["rangX1"])
	pass # Replace with function body.

func entratForatAll(area):
	if area.name == "ZonesForats":
		points += 5
	elif area.name == "Zona2":
		points += 10
		
	$Label.text = str(points)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	$MaTirAll.emit_signal("start")
	pass # Replace with function body.


func _on_stop_pressed():
	$MaTirAll.emit_signal("stop")
	pass # Replace with function body.


func _on_up_down_pressed():
	$MaTirAll.emit_signal("updown")
	pass # Replace with function body.


func _on_left_right_pressed():
	$MaTirAll.emit_signal("leftright")
	pass # Replace with function body.


func _on_obredits_pressed():
	allposition = $MaTirAll.position
	var hasDiana = dispararMaEsDiana(allposition)
	$MaTirAll.emit_signal("obredits",hasDiana)
	pass # Replace with function body.

func addPuntuacio(name):
	if name == "forat5" or name == "forat8":
		print("8 punts")
		points += 8
	elif name == "forat3" or name == "forat4":
		print("10 punts")
		points += 10
	elif name == "forat1" or name == "forat2" or name == "forat6" or name == "forat7":
		print("5 punts")
		points += 5
	pass
func dispararMaEsDiana(position):
	var hasDiana = false
	for diana in foratsValidsPosition:
		var posX = position.x
		var posY = position.y
		var isXInRange = isBetWeenRanges(diana["rangXmax"], diana["rangXmin"],int(posX))
		var isYInRange = isBetWeenRanges(diana["rangYmax"], diana["rangYmin"],int(posY))
		if isXInRange and isYInRange:
			print(position)
			print("Diana!!! " + diana["name"])
			hasDiana = true
			addPuntuacio(diana["name"])
	#		print(position)
		else:
			pass
	return hasDiana

func isBetWeenRanges(max, min, pos):
	#print(str(max)+" "+str(min)+" "+str(pos))
	return (pos >= min) and (pos <= max)	

	pass
