extends Node2D

@export var p1_amunt: String = "p1_move_up"
@export var p1_avall: String = "p1_move_down"
@export var p1_dreta: String = "p1_move_right"
@export var p1_esquerra: String = "p1_move_left"
@export var p1_accio: String = "p1_press_button"
@export var p1_accio2: String = "p1_press_buton2"

@export var p2_amunt: String = "p2_move_up"
@export var p2_avall: String = "p2_move_down"
@export var p2_dreta: String = "p2_move_right"
@export var p2_esquerra: String = "p2_move_left"
@export var p2_accio: String = "p2_press_button"
@export var p2_accio2: String = "p2_press_buton2"

var keymapsFile = "user://keymaps.dat"
var defaultKeymapFile = "res://keymapsOrg.cfg"
var keymaps: Dictionary
var OriginalKeymaps: Dictionary

var actions = [
	"p1_move_up",
	"p1_move_down",
	"p1_move_right",
	"p1_move_left",
	"p1_press_button",
	"p1_press_buton2",
	"p2_move_up",
	"p2_move_down",
	"p2_move_right",
	"p2_move_left",
	"p2_press_button",
	"p2_press_buton2"	
]

var actionsP2 = [
	"p2_move_up",
	"p2_move_down",
	"p2_move_right",
	"p2_move_left",
	"p2_press_button",
	"p2_press_buton2"
]
var currentAction = actions[0]
var actionsPos = 0

var allRedefined = false

func ConvertReadable(values):
	var line =""
	for value in values:
		line = JoinInformation(value.as_text())	+ " or " +line
	var substrLine = line.substr(0,line.length() - 3)
	return substrLine 	
func JoinInformation(value):
	print(value)
	var values = value.split(" ")
	if values[0] == "Joypad":
		if values[1] == "Button":
			return "Joy Btn "+values[2]
		if values.size() == 14:
			if values[4] == "1" and values[9] == "0" and values[13] == "-1.00":
				return "Joy Up"
			if values[4] == "1" and values[9] == "0" and values[13] == "1.00":
				return "Joy Down"
			if values[4] == "0" and values[9] == "0" and values[13] == "-1.00":
				return "Joy Left"
			if values[4] == "0" and values[9] == "0" and values[13] == "1.00":
				return "Joy Right"												
		return "Joy "+ values[5]
	else:
		if values[0] == "Shift":
			return "SHIFT"
		if values[0] == "End":
			return "END"
		
		return value

	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	#load_keymap()
	
	$P1/HBoxContainer/VBoxContainer2/Amunt.text = ConvertReadable(InputMap.action_get_events(p1_amunt))
	$P1/HBoxContainer/VBoxContainer2/Avall.text = ConvertReadable(InputMap.action_get_events(p1_avall))
	$P1/HBoxContainer/VBoxContainer2/Esquerra.text = ConvertReadable(InputMap.action_get_events(p1_esquerra))
	$P1/HBoxContainer/VBoxContainer2/Dreta.text = ConvertReadable(InputMap.action_get_events(p1_dreta))
	$P1/HBoxContainer/VBoxContainer2/Accio.text = ConvertReadable(InputMap.action_get_events(p1_accio))
	$P1/HBoxContainer/VBoxContainer2/Accio2.text = ConvertReadable(InputMap.action_get_events(p1_accio2))

	$P2/HBoxContainer/VBoxContainer2/Amunt.text = ConvertReadable(InputMap.action_get_events(p2_amunt))
	$P2/HBoxContainer/VBoxContainer2/Avall.text = ConvertReadable(InputMap.action_get_events(p2_avall))
	$P2/HBoxContainer/VBoxContainer2/Esquerra.text = ConvertReadable(InputMap.action_get_events(p2_esquerra))
	$P2/HBoxContainer/VBoxContainer2/Dreta.text = ConvertReadable(InputMap.action_get_events(p2_dreta))
	$P2/HBoxContainer/VBoxContainer2/Accio.text = ConvertReadable(InputMap.action_get_events(p2_accio))
	$P2/HBoxContainer/VBoxContainer2/Accio2.text = ConvertReadable(InputMap.action_get_events(p2_accio2))

	$btn_modification.text = "p1 amunt"
	pass # Replace with function body.
func UpdateLabelPerAction(actionModify,value):
	if currentAction == "p1_move_up":
		$P1/HBoxContainer/VBoxContainer2/Amunt.text = value
	if currentAction == "p1_move_down":
		$P1/HBoxContainer/VBoxContainer2/Avall.text = value
	if currentAction == "p1_move_left":
		$P1/HBoxContainer/VBoxContainer2/Esquerra.text = value
	if currentAction == "p1_move_right":
		$P1/HBoxContainer/VBoxContainer2/Dreta.text = value
	if currentAction == "p1_press_button":
		$P1/HBoxContainer/VBoxContainer2/Accio.text = value
	if currentAction == "p1_press_button2":
		$P1/HBoxContainer/VBoxContainer2/Accio2.text = value
	if currentAction == "p2_move_up":
		$P2/HBoxContainer/VBoxContainer2/Amunt.text = value
	if currentAction == "p2_move_down":
		$P2/HBoxContainer/VBoxContainer2/Avall.text = value
	if currentAction == "p2_move_left":
		$P2/HBoxContainer/VBoxContainer2/Esquerra.text = value
	if currentAction == "p2_move_right":
		$P2/HBoxContainer/VBoxContainer2/Dreta.text = value
	if currentAction == "p2_press_button":
		$P2/HBoxContainer/VBoxContainer2/Accio.text = value
	if currentAction == "p2_press_button2":
		$P2/HBoxContainer/VBoxContainer2/Accio2.text = value		

func isActionToBeCheck(value):
	var isAction = false
	for action in actions:
		if action == value:
			isAction = true
	
	return isAction

func updateModify():
	if currentAction == "p1_move_up":
		$btn_modification.text = "p1 amunt"
	if currentAction == "p1_move_down":
		$btn_modification.text = "p1 avall"
	if currentAction == "p1_move_left":
		$btn_modification.text = "p1 esquerra"
	if currentAction == "p1_move_right":
		$btn_modification.text = "p1 dreta"
	if currentAction == "p1_press_button":
		$btn_modification.text = "p1 accio"
	if currentAction == "p1_press_button2":
		$btn_modification.text = "p1 accio2"	
	if currentAction == "p2_move_up":
		$btn_modification.text = "p2 amunt"
	if currentAction == "p2_move_down":
		$btn_modification.text = "p2 avall"
	if currentAction == "p2_move_left":
		$btn_modification.text = "p2 esquerra"
	if currentAction == "p2_move_right":
		$btn_modification.text = "p2 dreta"
	if currentAction == "p2_press_button":
		$btn_modification.text = "p2 accio"
	if currentAction == "p2_press_button2":
		$btn_modification.text = "p2 accio2"	


func _unhandled_input(event) -> void:

	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed():
		print(event)
		var Allactions = InputMap.get_actions()
		for code in Allactions:
			if isActionToBeCheck(code):
				var events = InputMap.action_get_events(code)
				for ev in events:
					if ev is InputEventKey:
						if ev.keycode == event.keycode:
							print("KeyCode in use")
							InputMap.action_erase_event(code,ev)
							InputMap.action_add_event(currentAction, event)
						else:	
							InputMap.action_add_event(currentAction, event)
					#print(ev)
				pass
	#	InputHelper.replace_keyboard_input_at_index(action_name, changing_input_index, event, true)
		actionsPos += 1
		if actionsPos < actions.size():
			UpdateLabelPerAction(currentAction,event.as_text().substr(0,10))
			currentAction = actions[actionsPos]
			updateModify()
		else:
			Global.goto_scene("res://MainMenu/MainMenu.tscn")
		#if actionsPos < actions.size():
		#	print(currentAction)
			#var actions = InputMap.action_get_events(currentAction)
			#InputMap.action_erase_events(currentAction)
			#InputMap.action_add_event(currentAction, event)
		#	UpdateLabelPerAction(currentAction,event.as_text().substr(0,10))
		#	currentAction = actions[actionsPos]
		#	updateModify()
			#$P1/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(currentAction)[0].as_text().substr(0,10)
		#	print(event)	
			#keymaps[currentAction] = event	
		#	save_keymap()

		#	print(actionsPos)
			#if (actionsPos == actions.size()):
			#	currentAction = "Finish"
			#	$btn_modification.text = " P1 Redefined"
			#else:
			#	currentAction = actions[actionsPos]
		#else:
		#	print(actionsPos)
		#	print(actions.size())
		#	currentAction = "Finish"
		#	$btn_modification.text = " P1 Redefined"
		#	Global.goto_scene("res://MainMenu/MainMenu.tscn")
		#	InputHelper.replace_joypad_input_at_index(action_name, changing_input_index, event, true)

	elif (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.is_pressed():
		pass
		#actionsPos += 1
		#if actionsPos <= actions.size():
		#	InputMap.action_erase_events(currentAction)
		#	InputMap.action_add_event(currentAction, event)
		#	UpdateLabelPerAction(currentAction,InputMap.action_get_events(currentAction)[0].as_text().substr(0,10))
			#$P1/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(currentAction)[0].as_text().substr(0,10)
		#	print(event)	
		#	keymaps[currentAction] = event	
	#		save_keymap()
		#	print(currentAction)
		#	print(actionsPos)
		#	if (actionsPos == actions.size()):
		#		currentAction = "Finish"
		#		$btn_modification.text = " P1 Redefined"
		#	else:
		#		currentAction = actions[actionsPos]
		#else:
		#	print(actionsPos)
		#	print(actions.size())
		#	currentAction = "Finish"
		#	$btn_modification.text = " P1 Redefined"
		#	Global.goto_scene("res://MainMenu/MainMenu.tscn")
		#	InputHelper.replace_joypad_input_at_index(action_name, changing_input_index, event, true)

func save_keymap() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file := FileAccess.open(keymapsFile, FileAccess.WRITE)
	file.store_var(keymaps, true)
	file.close()

func load_keymap() -> void:
	if FileAccess.file_exists(defaultKeymapFile):
		var fileOriginal = FileAccess.open(defaultKeymapFile, FileAccess.READ)
		var OriginalKeymaps = fileOriginal.get_var(true) as Dictionary	
		fileOriginal.close()
		if not FileAccess.file_exists(keymapsFile):
			save_keymap() # There is no save file yet, so let's create one.
			return
		print("loadKEyMap")
		var file = FileAccess.open(keymapsFile, FileAccess.READ)
		var keymaps = file.get_var(true) as Dictionary	
		file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
		#print(OriginalKeymaps.keys())
		#print(keymaps.keys())
		for action in OriginalKeymaps.keys():
			var b = keymaps.get(action)
			
			if b != null:
				InputMap.action_erase_events(action)
				for act in b:
					InputMap.action_add_event(action, act)
			else:
				InputMap.action_erase_events(action)
				for act in OriginalKeymaps[action]:
					InputMap.action_add_event(action, act)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	if Input.is_action_pressed("exit"):
		Global.reset_keymap()
		Global.goto_Main()
