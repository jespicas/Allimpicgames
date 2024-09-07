extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func FillControls(arrayList):
	var pos = 0
	for n in arrayList:
		if n == "up":
			FillPosControl(pos,"up")
		if n == "down":
			FillPosControl(pos,"down")
		if n == "left":
			FillPosControl(pos,"left")
		if n == "right":
			FillPosControl(pos,"right")
		if n == "button":
			FillPosControl(pos,"button")
		pos += 1
			
func FillPosControl(pos,animationName):
	#print(str(pos) + " " + animationName)
	if pos == 0:
		$controlFirst.animation = animationName
		$controlFirst.modulate = Color(1,1,1)
	if pos == 1:
		$controlFirst2.animation = animationName
		$controlFirst2.modulate = Color(1,1,1)	
	if pos == 2:
		$controlFirst3.animation = animationName	
		$controlFirst3.modulate = Color(1,1,1)
	if pos == 3:
		$controlFirst4.animation = animationName
		$controlFirst4.modulate = Color(1,1,1)	
	if pos == 4:
		$controlFirst5.animation = animationName
		$controlFirst5.modulate = Color(1,1,1)

func reset():
	$controlFirst.modulate = Color(1,1,1)
	$controlFirst2.modulate = Color(1,1,1)
	$controlFirst3.modulate = Color(1,1,1)
	$controlFirst4.modulate = Color(1,1,1)
	$controlFirst5.modulate = Color(1,1,1)
	
func changeVisibility(pos):
	if pos == 0:
		$controlFirst.modulate = Color(0.42,0.42,0.41)
	if pos == 1:
		$controlFirst2.modulate = Color(0.42,0.42,0.41)
	if pos == 2:
		$controlFirst3.modulate = Color(0.42,0.42,0.41)
	if pos == 3:
		$controlFirst4.modulate = Color(0.42,0.42,0.41)
	if pos == 4:
		$controlFirst5.modulate = Color(0.42,0.42,0.41)
