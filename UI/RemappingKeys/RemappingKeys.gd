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
	"p1_press_buton2"
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

# Called when the node enters the scene tree for the first time.
func _ready():
	load_keymap()
	
	$P1/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(p1_amunt)[0].as_text()
	$P1/HBoxContainer/VBoxContainer2/Avall.text = InputMap.action_get_events(p1_avall)[0].as_text()
	$P1/HBoxContainer/VBoxContainer2/Esquerra.text = InputMap.action_get_events(p1_esquerra)[0].as_text()
	$P1/HBoxContainer/VBoxContainer2/Dreta.text = InputMap.action_get_events(p1_dreta)[0].as_text()
	$P1/HBoxContainer/VBoxContainer2/Accio.text = InputMap.action_get_events(p1_accio)[0].as_text()
	$P1/HBoxContainer/VBoxContainer2/Accio2.text = InputMap.action_get_events(p1_accio2)[0].as_text()

	$P2/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(p2_amunt)[0].as_text()
	$P2/HBoxContainer/VBoxContainer2/Avall.text = InputMap.action_get_events(p2_avall)[0].as_text()
	$P2/HBoxContainer/VBoxContainer2/Esquerra.text = InputMap.action_get_events(p2_esquerra)[0].as_text()
	$P2/HBoxContainer/VBoxContainer2/Dreta.text = InputMap.action_get_events(p2_dreta)[0].as_text()
	$P2/HBoxContainer/VBoxContainer2/Accio.text = InputMap.action_get_events(p2_accio)[0].as_text()
	$P2/HBoxContainer/VBoxContainer2/Accio2.text = InputMap.action_get_events(p2_accio2)[0].as_text()

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

	
func _unhandled_input(event) -> void:
	#if changing_input_index == -1: return
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

	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed():
		print(event)
	#	InputHelper.replace_keyboard_input_at_index(action_name, changing_input_index, event, true)
		actionsPos += 1
		if actionsPos < actions.size():
			print(currentAction)
			InputMap.action_erase_events(currentAction)
			InputMap.action_add_event(currentAction, event)
			UpdateLabelPerAction(currentAction,InputMap.action_get_events(currentAction)[0].as_text().substr(0,10))
			#$P1/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(currentAction)[0].as_text().substr(0,10)
			print(event)	
			keymaps[currentAction] = event	
			save_keymap()

			print(actionsPos)
			if (actionsPos == actions.size()):
				currentAction = "Finish"
				$btn_modification.text = " P1 Redefined"
			else:
				currentAction = actions[actionsPos]
		else:
			print(actionsPos)
			print(actions.size())
			currentAction = "Finish"
			$btn_modification.text = " P1 Redefined"
			Global.goto_scene("res://MainMenu/MainMenu.tscn")
		#	InputHelper.replace_joypad_input_at_index(action_name, changing_input_index, event, true)

	elif (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.is_pressed():
		actionsPos += 1
		if actionsPos <= actions.size():
			InputMap.action_erase_events(currentAction)
			InputMap.action_add_event(currentAction, event)
			$P1/HBoxContainer/VBoxContainer2/Amunt.text = InputMap.action_get_events(currentAction)[0].as_text().substr(0,10)
			print(event)	
			keymaps[currentAction] = event	
			save_keymap()
			print(currentAction)
			print(actionsPos)
			if (actionsPos == actions.size()):
				currentAction = "Finish"
				$btn_modification.text = " P1 Redefined"
			else:
				currentAction = actions[actionsPos]
		else:
			print(actionsPos)
			print(actions.size())
			currentAction = "Finish"
			$btn_modification.text = " P1 Redefined"
			Global.goto_scene("res://MainMenu/MainMenu.tscn")
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
		print(OriginalKeymaps.keys())
		print(keymaps.keys())
		for action in OriginalKeymaps.keys():
			var b = keymaps.get(action)
			
			if b != null:
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, b)
			else:
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, OriginalKeymaps[action])
				#print_debug(action)
				#print_debug(e)
	
#func load_keymap() -> void:
#	if not FileAccess.file_exists(keymapsFile):
#		print(keymapsFile+ " exist")
#		# Read DefaultValues 
#		var file = FileAccess.open(defaultKeymapFile, FileAccess.READ)
#		var keymaps = file.get_var(true) as Dictionary
#		save_keymap() 
#		var fileS = FileAccess.open(keymapsFile, FileAccess.READ)
#		var temp_keymap = fileS.get_var(true) as Dictionary
#		fileS.close()		# There is no save file yet, so let's create one.
#		for action in keymaps.keys():
#			if temp_keymap.has(action):
#				keymaps[action] = temp_keymap[action]
				# Whilst setting the keymap dictionary, we also set the
				# correct InputMap event
#				InputMap.action_erase_events(action)
#				InputMap.action_add_event(action, keymaps[action])		
#		return
#	var file = FileAccess.open(keymapsFile, FileAccess.READ)
#	var temp_keymap = file.get_var(true) as Dictionary
#	file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
#	for action in keymaps.keys():
#		if temp_keymap.has(action):
#			keymaps[action] = temp_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event
#			InputMap.action_erase_events(action)
#			InputMap.action_add_event(action, keymaps[action])
			
func reset_keymaps() -> void:
	DirAccess.remove_absolute(keymapsFile)	
	if FileAccess.file_exists(keymapsFile):
		print("no borrat")
	#var file = FileAccess.open(defaultKeymapFile, FileAccess.READ)
	#var keymaps = file.get_var(true) as Dictionary
	#var fileS := FileAccess.open(keymapsFile, FileAccess.WRITE)
	#fileS.store_var(keymaps, true)
	#fileS.close()
	load_keymap()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	if Input.is_action_pressed("exit"):
		reset_keymaps()
		Global.goto_Main()
