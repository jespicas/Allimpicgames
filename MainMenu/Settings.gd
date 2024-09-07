extends Node2D

var currentPosition = null
var allNicks = null
var nickExists = false
# Called when the node enters the scene tree for the first time.

func _ready():
	$LineEdit.grab_focus()
	currentPosition = 0
	$focusAll.hide()
	var settings = Global.GetSettings()
	$LineEdit.text = settings.nick
	allNicks = await Global.GetAllNickRegistered()
	print("Get all nicks")
	pass # Replace with function body.
func _on_TouchScreenButton_pressed():
	Global.goto_scene("res://MainMenu/MainMenu.tscn")
	pass # Replace with function body.

func _input(event):
	#print(event.is_action_released())
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		if currentPosition == 0:
			$LineEdit.text = $LineEdit.text.replace("\n","")
			$LineEdit.caret_column = $LineEdit.text.length()
		if currentPosition == 1:
			print("Save")
			var nickExists = false
			for nick in allNicks:
				if nick.nickName == $LineEdit.text:
					print ( " Nick name exists ")
					$MessageText.text = " El nick "+$LineEdit.text+" ja existeix prova amb un altre"
					$LineEdit.text = $LineEdit.text+"1"
				else:
					Global.SaveNick($LineEdit.text.to_upper())
					Global.goto_scene("res://MainMenu/MainMenu.tscn")
		if currentPosition == 2:
			Global.goto_scene("res://MainMenu/MainMenu.tscn")
			print("Back")
		if currentPosition == 3:
			Global.goto_scene("res://MainMenu/FriendsList.tscn")
				
		print("enter")
	if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left"):
		print("left")
		if currentPosition == 2:
			MoveToSave()
#	if event.is_action_pressed("p1_move_down") or event.is_action_pressed("p2_move_down"):
#		print("down")
#		if currentPosition == 0:
#			DisableLineEdit()
	if event.is_action_pressed("p1_move_up") or event.is_action_pressed("p2_move_up"):
		print("down")
		if currentPosition == 1 or currentPosition == 2:
			EnableLineEdit()

	if event.is_action_pressed("p1_move_right") or event.is_action_pressed("p2_move_right"):
		if currentPosition == 1:
			MoveToBack()
		print("right")
		
	if event.is_action_pressed("ui_focus_next") :
		if currentPosition == 0:
			DisableLineEdit()
			MoveToSave()
		elif currentPosition == 1:
			MoveToBack()
		elif currentPosition == 2:
			GotoListFriends()
		elif currentPosition == 3:
			EnableLineEdit()
			pass	
		print("focusnext")
		print(str(currentPosition))	

func GotoListFriends():
	currentPosition = 3
	$MessageText.text = ""
	$MessageText2.text = ""
	$ListFriends.grab_focus()
	$focusAll.position.x = 13
	$focusAll.position.y = 150
	
	
func EnableLineEdit():
	$LineEdit.editable = true
	$LineEdit.grab_focus()
	currentPosition = 0
	$LineEdit.caret_column = $LineEdit.text.length()
	$focusAll.hide()
	$MessageText.text = ""
	$MessageText2.text = ""
			
func DisableLineEdit():
	$LineEdit.editable = false	
	currentPosition = 1
	$focusAll.show()
	
func MoveToSave():
	$Guardar.grab_focus()
	currentPosition = 1
	$focusAll.position.x = 13
	$focusAll.position.y = 219
	if Global.hasConnection == true and allNicks != null:
		for nick in allNicks:
			if nick.nickName.to_upper() == $LineEdit.text.to_upper():
				print ( " Nick name exists ")
				$MessageText.text = " El nick "+$LineEdit.text+" ja existeix"
				$MessageText2.text = " prova amb un altre" 
				$LineEdit.text = $LineEdit.text+"1"	
func MoveToBack():
	print("mtb")
	$Back.grab_focus()
	currentPosition = 2	
	$focusAll.position.x = 225
	$focusAll.position.y = 219
	$MessageText.text = ""
	$MessageText2.text = ""


func _on_touchlistfriends_pressed():
	Global.goto_scene("res://MainMenu/FriendsList.tscn")
	pass # Replace with function body.
