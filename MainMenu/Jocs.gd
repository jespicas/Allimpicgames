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
	print(Global.tipusdeJoc)
	currentPosition = menupositions.JOCAGAFARALL
	pass # Replace with function body.

func IsMyFriend(nickToCheck):
	var friends = Global.GetFriends()
	var hasFriend = false
	for friend in friends:
		if friend == nickToCheck:
			print(friend)
			hasFriend = true
	
	return hasFriend

func GetScoreFriend(nick):
	for friend in Global.GetFriends():
		if friend.nick == nick:
			Global.scoreNickCompetir = friend.score
	pass
	
func GetScoreCompetitor(nick):
	for friend in Global.listPendingGames:
		if friend.nick == nick:
			Global.scoreNickCompetir = friend.score
	pass

func IsChecked(nickToChedk):
	var hasChecked = false
	for checkednick in checkedPenndings:
		if nickToChedk == checkednick:
			hasChecked = true
	return hasChecked

func HideAllGames():
	$agafarall.hide()
	$agafaAll.hide()
	$birrall.hide()
	$birralltouch.hide()
	$tiralall.hide()
	$tiralltouch.hide()
	$allioli.hide()
	$alliolitouch.hide()
	$lligaralls.hide()
	$lligartouch.hide()	
	$recollirall.hide()
	$recolliralltouch.hide()
func ShowAllGamesAndHideSeleccion():	
	$agafarall.show()
	$agafaAll.show()
	$birrall.show()
	$birralltouch.show()
	$tiralall.show()
	$tiralltouch.show()
	$allioli.show()
	$alliolitouch.show()
	$lligaralls.show()
	$lligartouch.show()
	$recollirall.show()
	$recolliralltouch.show()
	$ContentCompetir.hide()
	
func CheckToCompetir():
	if Global.tipusdeJoc == "competir" and Global.hasConnection == true:
		var pendingGames = await Global.GetPendingGames()
		var pendingGamesToYou = await Global.GetPendingGamesToYou()
		
		if checkedFriends == false:
			for pendinGame in pendingGamesToYou:
				#FirstCheckFriends
				#then check no friends
				if IsMyFriend(pendinGame.nick) == true:
					if IsChecked(pendinGame.nick) == false:
						print( " Amic vol competir " + pendinGame.nick)
						currentPosition = 89
						$AcceptCompetir.show()
						$AcceptCompetir/VolsCompetir.add_text(pendinGame.nick)
						$AcceptCompetir/VolsCompetir.add_text("?")
						Global.setNickCompetir(pendinGame.nick)				
				#else:
				#	print(checkedPenndings)
			checkedFriends = true
			print("Checked all friends")	#	print(IsChecked(pendinGame.nick))
		else:					#	print( " No es amic teu !" + pendinGame.nick)
			for pendinGame in pendingGames:
				if IsMyFriend(pendinGame.nick) == false:
					print("ismyfriend pending")
					print(pendinGame.nick)
					if IsChecked(pendinGame.nick) == false && pendinGame.nick != Global.currentNick:
						print( " NO Amic vol competir " + pendinGame.nick)
						currentPosition = 89
						$AcceptCompetir.show()
						$AcceptCompetir/VolsCompetir.add_text(pendinGame.nick)
						$AcceptCompetir/VolsCompetir.add_text("?")
						Global.setNickCompetir(pendinGame.nick)				
	
func GoToMainMenu():
	Global.goto_scene("res://MainMenu/MainMenu.tscn")
func SelectCompetitorAndGoToGame():
	var gamesYouWantToPlay = await Global.GetPendingGames()
	gamesPlaysToYou = await Global.GetPendingGamesToYou()
	var friends = Global.GetFriends()
	if gamesYouWantToPlay != null :
		HideAllGames()
		$ContentCompetir.show()
		$ContentCompetir/RichTextLabel.hide()
		$ContentCompetir/ListCompetidor.hide()
		$ContentCompetir/ListAmics.hide()
		$ContentCompetir/RichTextLabel2.hide()
		if gamesPlaysToYou.size() != 0:
			currentPosition = menupositions.COMPETIRCONTRATU
			mouAll(all.competircontratu)
			$ContentCompetir/RichTextLabel.show()
			$ContentCompetir/ListCompetidor.show()
			$ContentCompetir/ListCompetidor.clear()
			for playsToYou in gamesPlaysToYou:
				$ContentCompetir/ListCompetidor.add_item(playsToYou.nick)
		if friends.size() != 0 :
			$ContentCompetir/ListAmics.show()
			$ContentCompetir/RichTextLabel2.show()
			$ContentCompetir/ListAmics.clear()
			for friend in friends:
				if Global.ExistsGamePendingInSettings(friend, Global.currentGame) == false:
					$ContentCompetir/ListAmics.add_item(friend)
		if gamesPlaysToYou.size() == 0 and friends.size() != 0:
			currentPosition == menupositions.COMPETIRTUCONTRA
			mouAll(all.competirtucontra	)
			$ContentCompetir/ListAmics.grab_focus()
			$ContentCompetir/RichTextLabel.hide()
			$ContentCompetir/ListCompetidor.hide()
			currentPosition = menupositions.SELECCIOTUCONTRA
			$ContentCompetir/ListAmics.select(itemListFriendsposition)		
	if Global.hasConnection == false:
		GoToGame()
	#CheckToCompetir()
	#if Global.tipusdeJoc == "competir" and Global.hasConnection == true:
	#	pass
		#Comprova si tens partides pendents...
		#Comprova si hiha algun dels amics que vol competir  si es aixi : posar  el nick com a competir
		# si no es amic preguntar si accepta la competicio ,
		# si accepta posar nick a competir
		# si no accepta  buscar algu per competir 
		# si no hiha ningu que vulgui competir 
		# tria amic per competir
		#$ContentCompetir.show()
		#var getfriends = Global.GetFriends()
		#print(getfriends.size())
		#if getfriends != null:
		#	for nick in getfriends:
			#	print(nick)
		#		$ContentCompetir/ListAmics.add_item(nick,null,true)
		#	$ContentCompetir/ListAmics.select(0,false)
		#	$ContentCompetir/ListAmics.grab_focus()
		#	print($ContentCompetir/ListAmics.item_count)
		#	currentPosition = 99
	#else:
	#	Global.goto_scene("res://MiniGames/AgafaAlls.tscn")
func GoToGame():
	if Global.currentGame == "AgafaAlls":
		Global.goto_scene("res://MiniGames/AgafaAlls.tscn")
	elif Global.currentGame == "TiralaBirra":
		Global.goto_scene("res://MiniGames/TiralaBirra.tscn")
	elif Global.currentGame == "Tirall":
		Global.goto_scene("res://MiniGames/TiraAll.tscn")
	elif Global.currentGame == "ConcursAlliOli":
		Global.goto_scene("res://MiniGames/ConcursAlliOli.tscn")

func _on_backtouch_pressed(extra_arg_0):
	if extra_arg_0 == "btnBack":
		GoToMainMenu()
	if extra_arg_0 == "btnRecollir":
		pass
	if extra_arg_0 == "btnAgafaall":
		SelectCompetitorAndGoToGame()
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
	#print(event.is_action_released())
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		print(str(menupositions.keys()[currentPosition]))
		print("accept")
		print(currentPosition)
		if currentPosition == menupositions.JOCAGAFARALL:
			Global.setCurrentGame("AgafaAlls")
			if Global.tipusdeJoc == "practicar":
				GoToGame()
			SelectCompetitorAndGoToGame()
			pass
		elif currentPosition == menupositions.JOCBIRRALL:
			Global.setCurrentGame("TiralaBirra")
			GoToGame()
			pass
		elif currentPosition == menupositions.JOCTIRALL:
			Global.setCurrentGame("Tirall")
			GoToGame()
			pass
		elif currentPosition == menupositions.JOCALLIOLI:
			Global.setCurrentGame("ConcursAlliOli")
			GoToGame()			
			pass
		elif currentPosition == menupositions.JOCLLIGAR:
			pass
#		elif currentPosition == menupositions.JOCRECOLLIR:
#			pass
		elif currentPosition == menupositions.BACKBUTTON:
			GoToMainMenu()
			pass
		elif currentPosition == menupositions.COMPETIRCONTRATU:
			$ContentCompetir/ListCompetidor.grab_focus()
			$ContentCompetir/ListAmics.hide()
			$ContentCompetir/RichTextLabel2.hide()
			$ContentCompetir/ListCompetidor.select(itemListContraTuposition)
			var nicktocompetir = $ContentCompetir/ListCompetidor.get_item_text(itemListContraTuposition)
			for gametoplay in gamesPlaysToYou:
				if gametoplay.nick == nicktocompetir:
					Global.scoreNickCompetir = gametoplay.score
					Global.setPlayWithYou(true)
			currentPosition = menupositions.SELECCIOCONTRATU
		elif currentPosition == menupositions.COMPETIRTUCONTRA:
			print(" COMPETIRTUCONTRA")
			$ContentCompetir/ListAmics.grab_focus()
			$ContentCompetir/RichTextLabel.hide()
			$ContentCompetir/ListCompetidor.hide()
			currentPosition = menupositions.SELECCIOTUCONTRA
			$ContentCompetir/ListAmics.select(itemListFriendsposition)
		elif currentPosition == menupositions.SELECCIOTUCONTRA:
			print($ContentCompetir/ListAmics.get_item_text(itemListFriendsposition))
			Global.scoreNickCompetir = null
			Global.setNickCompetir($ContentCompetir/ListAmics.get_item_text(itemListFriendsposition))
			Global.setPlayWithYou(false)
			GoToGame()
			pass	
		elif currentPosition == menupositions.SELECCIOCONTRATU:
			print($ContentCompetir/ListCompetidor.get_item_text(itemListContraTuposition))
			GetScoreCompetitor($ContentCompetir/ListCompetidor.get_item_text(itemListContraTuposition))
			Global.setNickCompetir($ContentCompetir/ListCompetidor.get_item_text(itemListContraTuposition))
			GoToGame()
			pass
		print("enter")
		
	if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left"):
		print("left")
		print(str(menupositions.keys()[currentPosition]))
		if currentPosition == menupositions.BACKBUTTON:
			currentPosition = menupositions.JOCAGAFARALL
			mouAll(all.firstgame)
		elif currentPosition == menupositions.COMPETIRCONTRATU or currentPosition == menupositions.COMPETIRTUCONTRA or currentPosition == menupositions.SELECCIOCONTRATU or currentPosition == menupositions.SELECCIOTUCONTRA:
			#$ContentCompetir.hide()
			ShowAllGamesAndHideSeleccion()
			#$agafarall.show()
			#$agafaAll.show()
			mouAll(all.firstgame)
			currentPosition = menupositions.JOCAGAFARALL
		elif currentPosition == 21:
			currentPosition = 20
			$ContentCompetir/RichTextLabel.show()
			$ContentCompetir/ListCompetidor.show()
			$ContentCompetir/ListAmics.deselect_all()

	if event.is_action_pressed("p1_move_down") or event.is_action_pressed("p2_move_down"):
		print("down")
		#print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
		if currentPosition == menupositions.JOCAGAFARALL:
			currentPosition = menupositions.JOCBIRRALL
			mouAll(all.down)
			print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
			pass
		elif currentPosition == menupositions.JOCBIRRALL:
			currentPosition =  menupositions.JOCTIRALL
			mouAll(all.down)
			print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
			pass
		elif currentPosition == menupositions.JOCTIRALL:
			currentPosition = menupositions.JOCALLIOLI
			mouAll(all.down)
			print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
			pass
		elif currentPosition == menupositions.JOCALLIOLI:
			currentPosition = menupositions.JOCLLIGAR
			mouAll(all.down)
			print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
			pass
		elif currentPosition == menupositions.JOCLLIGAR:
			currentPosition = menupositions.BACKBUTTON
			mouAll(all.backbutton)
			print(str(menupositions.keys()[currentPosition])+ " " + str(currentPosition))
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
		print(currentPosition)
		print("up")
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
		print("right")
		print(currentPosition)
		#if currentPosition != 99:
		#	currentPosition = 6
		#	$focusAll.position.x = 240
		#	$focusAll.position.y = 210
		#if currentPosition == menupositions.COMPETIRCONTRATU:
		#	currentPosition = 5
		#	$ContentCompetir.hide()
		#	$focusAll.position.x = 240
		#	$focusAll.position.y = 210
		#	$agafarall.show()
		#	$agafaAll.show()
		
	if event.is_action_pressed("ui_focus_next") :
		pass
