extends Node2D

enum menupositions {JOCAGAFARALL, JOCBIRRALL, JOCTIRALL, JOCALLIOLI, JOCLLIGAR,  BACKBUTTON, COMPETIRCONTRATU, COMPETIRTUCONTRA, SELECCIOCONTRATU, SELECCIOTUCONTRA}

enum all {up, down, backbutton, lastgame, competircontratu, competirtucontra, firstgame}

var currentPosition = null
var itemListFriendsposition = 0
var itemListContraTuposition = 0

var checkedPenndings = []
var checkedFriends = false
var gamesPlaysToYou = null

func _ready():
	currentPosition = menupositions.JOCAGAFARALL
	pass # Replace with function body.


func GoToMainMenu():
	Global.goto_scene("res://MainMenu/MainMenu.tscn")

func GoToGame():
	if currentPosition == menupositions.JOCAGAFARALL:
		Global.goto_scene("res://Instruccions/AgafaAllsInstructions.tscn")
	elif currentPosition == menupositions.JOCBIRRALL:
		Global.goto_scene("res://Instruccions/TiralaBirraInstructions.tscn")
	elif currentPosition == menupositions.JOCTIRALL:
		Global.goto_scene("res://Instruccions/TiraLAllInstructions.tscn")
	elif currentPosition == menupositions.JOCALLIOLI:
		Global.goto_scene("res://Instruccions/AlliOliInstructions.tscn")
	elif currentPosition == menupositions.JOCLLIGAR:
		Global.goto_scene("res://Instruccions/EnforcarAllsInstructions.tscn")
		

func _on_backtouch_pressed(extra_arg_0):
	if extra_arg_0 == "btnBack":
		GoToMainMenu()
	if extra_arg_0 == "btnRecollir":
		pass
	if extra_arg_0 == "btnAgafaall":
		pass # Replace with function body.

func mouAll(pos):
	if pos == all.up:
		$focusAll.position.y = $focusAll.position.y - 20
	elif pos == all.down:
		$focusAll.position.y = $focusAll.position.y + 20
	elif pos == all.backbutton:
		$focusAll.position.x = 240
		$focusAll.position.y = 210
	elif pos == all.lastgame:
		$focusAll.position.x = 21
		$focusAll.position.y = 135
	elif pos == all.competircontratu:
		$focusAll.position.x = 45
		$focusAll.position.y = 20
	elif pos == all.competirtucontra:	
		$focusAll.position.y = 95
	elif pos == all.firstgame:
		$focusAll.position.x = 21
		$focusAll.position.y = 52

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		if currentPosition == menupositions.JOCAGAFARALL:
			GoToGame()
			pass
		elif currentPosition == menupositions.JOCBIRRALL:
			GoToGame()
			pass
		elif currentPosition == menupositions.JOCTIRALL:
			GoToGame()
			pass
		elif currentPosition == menupositions.JOCALLIOLI:
			GoToGame()			
			pass
		elif currentPosition == menupositions.JOCLLIGAR:
			GoToGame()			
			pass
		elif currentPosition == menupositions.BACKBUTTON:
			GoToMainMenu()
			pass
		
	if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left"):
		if currentPosition == menupositions.BACKBUTTON:
			currentPosition = menupositions.JOCAGAFARALL
			mouAll(all.firstgame)
		elif currentPosition == menupositions.COMPETIRCONTRATU or currentPosition == menupositions.COMPETIRTUCONTRA or currentPosition == menupositions.SELECCIOCONTRATU or currentPosition == menupositions.SELECCIOTUCONTRA:
			mouAll(all.firstgame)
			currentPosition = menupositions.JOCAGAFARALL
		elif currentPosition == 21:
			currentPosition = 20
			$ContentCompetir/RichTextLabel.show()
			$ContentCompetir/ListCompetidor.show()
			$ContentCompetir/ListAmics.deselect_all()

	if event.is_action_pressed("p1_move_down") or event.is_action_pressed("p2_move_down"):
		if currentPosition == menupositions.JOCAGAFARALL:
			currentPosition = menupositions.JOCBIRRALL
			mouAll(all.down)
			pass
		elif currentPosition == menupositions.JOCBIRRALL:
			currentPosition =  menupositions.JOCTIRALL
			mouAll(all.down)
			pass
		elif currentPosition == menupositions.JOCTIRALL:
			currentPosition = menupositions.JOCALLIOLI
			mouAll(all.down)
			pass
		elif currentPosition == menupositions.JOCALLIOLI:
			currentPosition = menupositions.JOCLLIGAR
			mouAll(all.down)
			pass
		elif currentPosition == menupositions.JOCLLIGAR:
			currentPosition = menupositions.BACKBUTTON
			mouAll(all.backbutton)
			pass
#		elif currentPosition == menupositions.JOCRECOLLIR:
#			currentPosition = menupositions.BACKBUTTON
#			mouAll(all.backbutton)
			pass
		elif currentPosition == menupositions.COMPETIRCONTRATU:
			currentPosition = menupositions.COMPETIRTUCONTRA
			mouAll(all.competirtucontra)
		elif currentPosition == menupositions.SELECCIOTUCONTRA:
			if itemListFriendsposition+1 < $ContentCompetir/ListAmics.get_item_count():
				itemListFriendsposition = itemListFriendsposition + 1
				$ContentCompetir/ListAmics.select(itemListFriendsposition,true)
		elif currentPosition == menupositions.SELECCIOCONTRATU:
			if itemListContraTuposition+1 < $ContentCompetir/ListCompetidor.get_item_count():
				itemListContraTuposition = itemListContraTuposition + 1
				$ContentCompetir/ListAmics.select(itemListContraTuposition,true)
				
	if event.is_action_pressed("p1_move_up") or event.is_action_pressed("p2_move_up"):
		if currentPosition == menupositions.JOCBIRRALL:
			currentPosition = menupositions.JOCAGAFARALL
			mouAll(all.up)
			pass
		elif currentPosition ==  menupositions.JOCTIRALL:
			currentPosition = menupositions.JOCBIRRALL
			mouAll(all.up)
			pass
		elif currentPosition == menupositions.JOCALLIOLI:
			currentPosition =  menupositions.JOCTIRALL
			mouAll(all.up)
			pass
		elif currentPosition == menupositions.JOCLLIGAR:
			currentPosition = menupositions.JOCALLIOLI
			mouAll(all.up)
			pass
	#	elif currentPosition == menupositions.JOCRECOLLIR:
	#		currentPosition = menupositions.JOCLLIGAR
	#		mouAll(all.up)
		elif currentPosition == menupositions.BACKBUTTON:
			currentPosition = menupositions.JOCLLIGAR
			mouAll(all.lastgame)			
		elif currentPosition == menupositions.COMPETIRTUCONTRA:
			currentPosition = menupositions.COMPETIRCONTRATU
			mouAll(all.competircontratu)
		elif currentPosition == menupositions.SELECCIOTUCONTRA:
			if itemListFriendsposition-1 >= 0:
				itemListFriendsposition = itemListFriendsposition - 1
				$ContentCompetir/ListAmics.select(itemListFriendsposition,true)
		elif currentPosition == menupositions.SELECCIOCONTRATU:
			if itemListContraTuposition-1 >= 0:
				itemListContraTuposition = itemListContraTuposition - 1
				$ContentCompetir/ListCompetidor.select(itemListContraTuposition,true)

			pass

	if event.is_action_pressed("p1_move_right") or event.is_action_pressed("p2_move_right"):
		pass
	if event.is_action_pressed("ui_focus_next") :
		pass
