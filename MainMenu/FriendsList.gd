extends Node2D

var currentPosition = null
var itemListposition = 0
var itemListpositionAmics = 0

enum menupositions {BACK, LISTNICKS, LISTAMICS}
# Called when the node enters the scene tree for the first time.
func _ready():
	currentPosition = 1
	$focusAll.position.x = 20
	$focusAll.position.y = 120
	$ItemList.grab_focus()
	$ItemList.show()
	var getfriends = Global.GetFriends()
	if getfriends != null:
		for nick in getfriends:
			$ListAmics.add_item(nick,null,true)
		$ListAmics.select(0,false)
	if Global.listNick != null:
		for nick in Global.listNick:
			if nick.nickName != Global.GetCurrentNick():
				$ItemList.add_item(nick.nickName,null,true)
		$ItemList.select(0,false)
	else:
		$llistaTriar.hide()
		$ItemList.hide()
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		if currentPosition == menupositions.BACK:
			Global.goto_scene("res://MainMenu/Settings.tscn")
		elif currentPosition == menupositions.LISTNICKS:
			var itemselected = $ItemList.get_item_text(itemListposition)
			$ListAmics.add_item(itemselected, null, true)
			var friends = []
			var countFriends = $ListAmics.item_count
			for n in countFriends:
				friends.append($ListAmics.get_item_text(n))
			Global.AddFriends(friends)
		elif currentPosition == menupositions.LISTAMICS:
			$ListAmics.remove_item(itemListpositionAmics)
			itemListpositionAmics = 0
			var friends = []
			var countFriends = $ListAmics.item_count
			for n in countFriends:
				friends.append($ListAmics.get_item_text(n))
			Global.AddFriends(friends)
				
	if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left"):
		if currentPosition == menupositions.LISTNICKS:
			currentPosition = menupositions.LISTAMICS
			$focusAll.position.x = 20
			$focusAll.position.y = 20
		elif currentPosition == menupositions.BACK:
			currentPosition = menupositions.LISTNICKS
			$focusAll.position.x = 20
			$focusAll.position.y = 120
		elif currentPosition == menupositions.LISTAMICS:
			currentPosition = menupositions.BACK
			$focusAll.position.x = 120
			$focusAll.position.y = 180			
			pass
	if event.is_action_pressed("p1_move_down") or event.is_action_pressed("p2_move_down"):
		printCurrentPostion()
		if currentPosition == menupositions.LISTNICKS:
			itemListposition = itemListposition + 1
			$ItemList.select(itemListposition,true)
		elif currentPosition == menupositions.LISTAMICS:
			itemListpositionAmics = itemListpositionAmics + 1
			$ListAmics.select(itemListpositionAmics,true)

	if event.is_action_pressed("p1_move_up") or event.is_action_pressed("p2_move_up"):
		printCurrentPostion()
		if currentPosition == menupositions.LISTNICKS:
			if itemListposition -1  >= 0:
				itemListposition = itemListposition - 1
			$ItemList.select(itemListposition,true)
		elif currentPosition == menupositions.LISTAMICS:
			if itemListpositionAmics -1 >= 0:
				itemListpositionAmics = itemListpositionAmics -1
			$ListAmics.select(itemListpositionAmics, true)


	if event.is_action_pressed("p1_move_right") or event.is_action_pressed("p2_move_right"):
		if currentPosition == menupositions.LISTNICKS:
			currentPosition = menupositions.BACK
			$focusAll.position.x = 230
			$focusAll.position.y = 220
		elif currentPosition == menupositions.BACK:
			currentPosition = menupositions.LISTAMICS
			$focusAll.position.x = 20
			$focusAll.position.y = 20
			pass
		elif currentPosition == menupositions.LISTAMICS:
			currentPosition = menupositions.LISTNICKS
			$focusAll.position.x = 20
			$focusAll.position.y = 120
		
	if event.is_action_pressed("ui_focus_next") :
		if currentPosition == 0:
			MoveToBack
			pass
		elif currentPosition == 1:
			pass

		elif currentPosition == 2:

			pass	

func _on_touch_screen_button_pressed():
	Global.goto_scene("res://MainMenu/Settings.tscn")
	pass # Replace with function body.

func printCurrentPostion():
	if currentPosition == menupositions.BACK:
		pass
	if currentPosition == menupositions.LISTAMICS:
		pass
	if currentPosition == menupositions.LISTNICKS:
		pass
func MoveToBack():

	$Back.grab_focus()
	currentPosition = 2	
	$focusAll.position.x = 225


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	pass # Replace with function body.
