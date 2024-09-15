extends CanvasLayer

enum menupositions {SI, NO}
var currentPosition = null
var menuRetry = false

var currentGame = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	currentPosition = menupositions.SI
	if menuRetry == false :
		hideRetry()
	pass # Replace with function body.


func colorBlack():
	$Volstornarhi.add_theme_color_override("default_color",Color("black"))
	$Si.add_theme_color_override("default_color",Color("black"))
	$No.add_theme_color_override("default_color",Color("black"))
	
func _process(delta):
	pass

func hideRetry():
	$Volstornarhi.hide()
	$Si.hide()
	$No.hide()
	$siTouch.hide()
	$NoTouch.hide()
	$focusAll.hide()
	$CanvasGroup.hide()
	menuRetry = false

func ShowRetry():
	$Volstornarhi.show()
	$Si.show()
	$No.show()
	$siTouch.show()
	$NoTouch.show()
	$focusAll.show()
	$CanvasGroup.show()
	menuRetry = true
	
	
func _input(event):
	if menuRetry == true:
			if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
				print(currentPosition)
				if currentPosition == menupositions.SI:
					Global.goto_scene("res://MiniGames/"+currentGame+".tscn")
					pass
				if currentPosition == menupositions.NO:
					if await Global.ShouldAddScore():
						Global.goto_SaveRecords()
					else:
						Global.goto_Jocs()
 					#Global.goto_scene("res://MainMenu/Jocs.tscn")
					pass	
				pass
			if event.is_action_pressed("p1_move_left") or event.is_action_pressed("p2_move_left") or event.is_action_pressed("p1_move_right") or event.is_action_pressed("p2_move_right"):
				print(currentPosition)
				if currentPosition == menupositions.SI:
					$focusAll.position.x = 210
					currentPosition = menupositions.NO
					pass
				elif currentPosition == menupositions.NO:
					$focusAll.position.x = 90
					currentPosition = menupositions.SI
					pass					
				pass

	pass


func _on_si_touch_pressed():
	Global.goto_scene("res://MiniGames/"+currentGame+".tscn")
	pass # Replace with function body.


func _on_no_touch_pressed():
	Global.goto_scene("res://MainMenu/Jocs.tscn")
	pass # Replace with function body.
