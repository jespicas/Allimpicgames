extends CanvasLayer

const SECONDS_PER_MINUTE : int = 60

var m_CurrentTimeSeconds : int = 0

signal timeexpired
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func setColor(color):
	if color == "black":
		$P2Time.add_theme_color_override("font_color", Color(0,0,0))
		$P1Time.add_theme_color_override("font_color", Color(0,0,0))
		$Message.add_theme_color_override("font_color", Color(0,0,0))
		$Message.add_theme_font_size_override("font_size",8)
		$Message2.add_theme_color_override("font_color", Color(0,0,0))
		$Timing.add_theme_color_override("font_color", Color(0,0,0))
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Timer.start()
	pass # Replace with function body.

func show_message(text):
	$Message.visible = true
	$Message.show()
	$MessageMiddle.show()
	$Message.text = text
func show_message2(text):
	$Message2.visible = true
	$Message2.show()
	$Message2.text = text

	
func show_messageP1(text):
	$P1Time.visible = true
	$P1Time.show()
	$P1Time.text = text
	
func show_messageP2(text):
	$P2Time.visible = true
	$P2Time.show()
	$P2Time.text = text	
	
func hideMessage():
	$Message.text = ""
	$Message.visible = false
	$MessageMiddle.hide()
	
func hideMessage2():
	$Message2.text = ""
	$Message2.visible = false
	
func hideMessageP1():
	$P1Time.text = ""
	$P1Time.visible = false
func hideMessageP2():
	$P2Time.text = ""
	$P2Time.visible = false

func hideTiming():
	$TimingGroup.hide()
	$Timing.visible = false
	
func showTiming():
	$TimingGroup.show()
	$Timing.visible = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _GetSeconds(seconds : int) -> int:
	return (seconds % SECONDS_PER_MINUTE)
	
func updateSeconds(seconds: int) -> void:
	$Timing.text = str(_GetSeconds(seconds))

func _on_timer_timeout():
	m_CurrentTimeSeconds = (m_CurrentTimeSeconds + 1)
	updateSeconds(m_CurrentTimeSeconds)
	if m_CurrentTimeSeconds == 60:
		$Timer.stop()
		emit_signal("timeexpired")
	pass # Replace with function body.
