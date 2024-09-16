extends CharacterBody2D

signal stopLeftRight
signal stopUpDown
signal allTirat
signal init
signal start
signal stop
signal updown
signal leftright
signal obredits(hasDiana)
signal alldintreforat
signal allforacau

signal disablecollisionallxoca

const SPEED = 3.0
const JUMP_stopUpDownVELOCITY = -400.0

var positionX = 0
var positionY = 214
var direction = "right"
var stopLeftRightHand = false
var stopUpDownHand = false
var a 
var b
var tirades = 0
var shoutBeMove = false
var lastAllPosition
var allTiratAction = false

var hafetDiana = false

func Init():
	positionX = 0
	positionY = 214
	position.x = 0
	position.y = 214
	direction = "right"
	stopLeftRightHand = false
	stopUpDownHand = false
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("default")
	
func Start():
	if allTiratAction == true:
		allTiratAction = false
		Init()
	$AnimatedSprite2D.show()
	shoutBeMove = true
	
func Stop():
	shoutBeMove = false

func UpDown():
	direction = "up"
func LeftRight():
	direction = "left"
func ObreDits(hasDiana):
	hafetDiana = hasDiana
	Stop()
	$AnimatedSprite2D.play("obredits")
func AllDintreForat():
	pass
func AllForaCau():
	$Allxoca/AnimatedSprite2D.play("xoca")
	$Allxoca.caure == true

func disableCollisionAllXoca():
	if $Allxoca/CollisionPolygon2D.disabled == true:
		$Allxoca/CollisionPolygon2D.disabled = false
	else:
		$Allxoca/CollisionPolygon2D.disabled = true
			
func _ready():
	a = position.x
	b = position.y
	
	connect("init", Callable(self, "Init"))
	connect("start", Callable(self, "Start"))
	connect("stop", Callable(self, "Stop"))
	connect("updown", Callable(self, "UpDown"))
	connect("leftright", Callable(self, "LeftRight"))
	connect("obredits", Callable(self, "ObreDits"))
	connect("alldintreforat", Callable(self, "AllDintreForat"))
	connect("allforacau", Callable(self, "AllForaCau"))	
	connect("disablecollisionallxoca", Callable(self, "disableCollisionAllXoca"))
	connect("stopLeftRight", Callable(self, "stop_Left_Right"))
	connect("stopUpDown", Callable(self, "stop_Up_Down"))
	
	pass
func animacioxoca():
	$AnimatedSprite2D.play("default")
	Init()		
	pass
	
	
func stop_Left_Right():
	stopLeftRightHand = true
	direction = "up"
	pass

func stop_Up_Down():
	stopUpDownHand = true
	pass

func _physics_process(delta):
	if shoutBeMove == true:
		$Label.text = "X:"+str(position.x)+"Y:"+str(position.y)
		if position.x <= 320 and direction == "right" and stopLeftRightHand == false:
			positionX = position.x + SPEED
			position.x = positionX
			move_and_slide()
			if position.x >= 320:
				direction = "left"
			pass
		if position.x >= 0 and direction == "left" and stopLeftRightHand == false:
			positionX = position.x - SPEED
			position.x = positionX
			if position.x <= 0 and direction == "left":
				direction = "right"
		if direction == "up" and stopUpDownHand == false:
			positionY = position.y - SPEED
			position.y = positionY
			if position.y <= 0:
				direction = "down"
		if direction == "down" and stopUpDownHand == false :
			positionY = position.y + SPEED
			position.y = positionY
			if position.y >= 214:
				direction = "up"
			
func _on_animated_sprite_2d_animation_finished():
	allTiratAction = true
	$AnimatedSprite2D.hide()
	$Allxoca.position = position
	var initialPosition = $Allxoca.position
	
	$Allxoca.position.y = $Allxoca.position.y - 4
	$Allxoca.position.x = $Allxoca.position.x + 15
	lastAllPosition = $Allxoca.position
	$Allxoca.show()
	$Allxoca.emit_signal("disparat",hafetDiana)
	pass # Replace with function body.
