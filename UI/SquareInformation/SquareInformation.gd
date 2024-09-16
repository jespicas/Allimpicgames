extends Node2D

#var abaixdreta = preload("res://UI/SquareInformation/abaixdreta.tscn")
#var abaixesquerra = preload("res://UI/SquareInformation/abaixesquerra.tscn")
#var adaltdreta = preload("res://UI/SquareInformation/adaltdreta.tscn")
#var adaltesquerra = preload("res://UI/SquareInformation/adaltesquerra.tscn")
#var background = preload("res://UI/SquareInformation/background.tscn")
#var horitzontal = preload("res://UI/SquareInformation/horitzontal.tscn")
#var vertical = preload("res://UI/SquareInformation/vertical.tscn")
signal allTextShown
signal hiddenSquare

var is_Showing = false
var WaitReadyToEnable = false
var pagination = 1
var numberofPages = 0
var currentPage 
var startPage = 0
var endPage = 10

var textsToWork
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Label.name = "original"	
#	var text = [
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo",
#		"Provarem de posar algo"		
#	]
	
#	ShowSquare(text)


	pass # Replace with function body.
func _input(event):
	if is_Showing == true  and WaitReadyToEnable == true: 
		if Input.is_action_just_released("p2_press_button") or Input.is_action_just_released("p1_press_button"):
			if currentPage < numberofPages:
				clearText()
				startPage += 10
				endPage +=10
				EmplaneText(textsToWork)
				currentPage +=1
				#AddLineText(textsToWork[11],30,35)
			else:
			# 	pass
				finishShown()

func finishShown():
	is_Showing = false
	emit_signal("allTextShown")
	
func clearText():
	for _i in self.get_children():
		if _i is Label:
			if _i.name != "original" and _i.name != "Label":
				_i.queue_free()

func ShowSquareP2(posXAdaltEsquerra,posYAdaltEsquerra,posXAbaixEsquerra,poxYAbaixEsquerra,posXAdaltDreta,posYAdaltDreta,posXAbaixDreta,poxYAbaixDreta,texts,amagar):
	clearText()
	show()
	AddBackgroundWithPos(posXAdaltEsquerra+10,posYAdaltEsquerra,4,3)	
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAdaltEsquerra,n,"vertical",false,false)
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAbaixDreta,n,"vertical",true,false)
			
	for n in posXAbaixDreta-10:
		if n > posXAdaltEsquerra+20:
			AddObject(n,posYAdaltEsquerra,"horitzontal",false,false)

	for n in posXAbaixDreta-10:
		if n > posXAbaixEsquerra+10:
			AddObject(n,poxYAbaixEsquerra,"horitzontal",false,true)				
			
	AddObject(posXAdaltEsquerra,posYAdaltEsquerra,"adaltesquerra",false,false)
	AddObject(posXAbaixEsquerra,poxYAbaixEsquerra,"abaixesquerra",false,false)
	AddObject(posXAdaltDreta,posYAdaltDreta,"adaltdreta",false,false)
	AddObject(posXAbaixDreta,poxYAbaixDreta,"abaixdreta",false,false)
	AddLineText(texts[0], posXAdaltEsquerra, posYAdaltEsquerra)
	AddLineText(texts[1], posXAdaltEsquerra, posYAdaltEsquerra+10)
	AddLineText(texts[2], posXAdaltEsquerra, posYAdaltEsquerra+20)
	if amagar == true:
		$Timer.start(2)

func ShowSquareFixed(posXAdaltEsquerra,posYAdaltEsquerra,posXAbaixEsquerra,poxYAbaixEsquerra,posXAdaltDreta,posYAdaltDreta,posXAbaixDreta,poxYAbaixDreta,texts):
	clearText()
	show()
	AddBackgroundWithPos(posXAdaltEsquerra+10,posYAdaltEsquerra,4,3)	
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAdaltEsquerra,n,"vertical",false,false)
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAbaixDreta,n,"vertical",true,false)
			
	for n in posXAbaixDreta-10:
		if n > posXAdaltEsquerra+20:
			AddObject(n,posYAdaltEsquerra,"horitzontal",false,false)

	for n in posXAbaixDreta-10:
		if n > posXAbaixEsquerra+10:
			AddObject(n,poxYAbaixEsquerra,"horitzontal",false,true)				
			
	AddObject(posXAdaltEsquerra,posYAdaltEsquerra,"adaltesquerra",false,false)
	AddObject(posXAbaixEsquerra,poxYAbaixEsquerra,"abaixesquerra",false,false)
	AddObject(posXAdaltDreta,posYAdaltDreta,"adaltdreta",false,false)
	AddObject(posXAbaixDreta,poxYAbaixDreta,"abaixdreta",false,false)
	AddLineText(texts[0], posXAdaltEsquerra, posYAdaltEsquerra)
	AddLineText(texts[1], posXAdaltEsquerra, posYAdaltEsquerra+10)
	AddLineText(texts[2], posXAdaltEsquerra, posYAdaltEsquerra+20)

func ShowEmptySquare(posXAdaltEsquerra,posYAdaltEsquerra,posXAbaixEsquerra,poxYAbaixEsquerra,posXAdaltDreta,posYAdaltDreta,posXAbaixDreta,poxYAbaixDreta):
	clearText()
	show()
	AddBackgroundWithPos(posXAdaltEsquerra+10,posYAdaltEsquerra,4,3)	
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAdaltEsquerra,n,"vertical",false,false)
	for n in posYAdaltEsquerra+20:
		if n > posYAdaltEsquerra+10:
			AddObject(posXAbaixDreta,n,"vertical",true,false)
			
	for n in posXAbaixDreta-10:
		if n > posXAdaltEsquerra+20:
			AddObject(n,posYAdaltEsquerra,"horitzontal",false,false)

	for n in posXAbaixDreta-10:
		if n > posXAbaixEsquerra+10:
			AddObject(n,poxYAbaixEsquerra,"horitzontal",false,true)				
			
	AddObject(posXAdaltEsquerra,posYAdaltEsquerra,"adaltesquerra",false,false)
	AddObject(posXAbaixEsquerra,poxYAbaixEsquerra,"abaixesquerra",false,false)
	AddObject(posXAdaltDreta,posYAdaltDreta,"adaltdreta",false,false)
	AddObject(posXAbaixDreta,poxYAbaixDreta,"abaixdreta",false,false)
	# 190,60
	# 190,100
	# 280,60
	# 280,100
	
func ShowSquare(texts):
	is_Showing = true
	numberofPages = ceil(float(texts.size())/10)
	textsToWork = texts
	EmplaneText(textsToWork)
	currentPage = 1
	
	for n in 200:
		if n > 40:
			AddObject(30,n,"vertical",false,false)
	
	for n in 200:
		if n > 40:
			AddObject(280,n,"vertical",true,false)		
	
	for n in 270:
		if n > 40:
			AddObject(n,40,"horitzontal",false,false)		

	for n in 270:
		if n > 40:
			AddObject(n,200,"horitzontal",false,true)							

	AddBackground()	
	AddObject(30,40,"adaltesquerra",false,false)
	AddObject(30,200,"abaixesquerra",false,false)
	AddObject(280,40,"adaltdreta",false,false)
	AddObject(280,200,"abaixdreta",false,false)	
		
func EmplaneText(texts):
	var initialPost = 35
	print(startPage)
	print(endPage)
	for i in range(startPage,endPage):
		if i < texts.size():
			AddLineText(texts[i],30,initialPost)
		else:
			AddLineText("",30,initialPost)
		initialPost += 15
		
	AddLineText("next per continuar",50,185)	
	
func AddLineText(text,posX, posY):
	var label = $Label.duplicate()
	label.name = "line"
	label.text = text
	label.set_position(Vector2(posX,posY))
	label.add_theme_font_size_override("font_size", 10)
	add_child(label)
	
func AddBackgroundWithPos(posX, posY, cols, lines):
	var posInitial = posX
	var DrawPosY = posY
	for i in lines:		
		AddLineBackground(posInitial,DrawPosY,cols)	
		posInitial = posX
		DrawPosY += 15

func AddLineBackground(posX, posY, cols):
	var posInitial = posX
	for x in cols:		
		AddObject(posInitial,posY,"background",false,false)
		posInitial += 22
		
func AddBackground():
	var posInitial = 54
	for x in 7:
		AddLineBackgrounds(posInitial)
		posInitial += 22	

func AddLineBackgrounds(posY):
	var postInitial = 48
	for n in 11:
		AddObject(postInitial,posY,"background",false,false)
		postInitial += 22
				
func AddObject(x,y, imageName,flipe,flipeV):
	var sprite2 = $Sprite2D.duplicate()
	var image = Image.load_from_file("res://Media/imatges/squareAlls/"+imageName+".png")
	var texture = ImageTexture.create_from_image(image)
	sprite2.texture = texture
	sprite2.position.x = x
	sprite2.position.y = y
	sprite2.set_flip_h(flipe)
	sprite2.set_flip_v(flipeV)
	
	add_child(sprite2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Timer.stop()
	hide()
	emit_signal("hiddenSquare")
	pass # Replace with function body.


func _on_wait_ready_to_enable_timeout():
	WaitReadyToEnable = true
	pass # Replace with function body.
