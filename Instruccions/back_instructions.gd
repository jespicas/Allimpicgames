extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event):
	#print(event.is_action_released())
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("p1_press_button") or event.is_action_pressed("p2_press_button"):
		Global.goto_scene("res://Instruccions/JocsInstruccions.tscn")
