extends CenterContainer


signal update_health(amount)
signal update_health_critical(amount)
signal reset

@export var value: float = 0.0

func setupHelthBar(direction):
	if "RightToLeft":
		$UnderBar.set_fill_mode(1)
		$OverBar.set_fill_mode(1)
	else:
		$UnderBar.set_fill_mode(0)
		$OverBar.set_fill_mode(0)
	

func _ready() -> void:
	connect("update_health", Callable(self, "_on_update_health"))
	connect("update_health_critical", Callable(self, "_on_update_health_critical"))
	connect("reset", Callable(self, "_on_reset"))


func _on_update_health(_value: float) -> void:
	value = _value
	var tween = create_tween()
	$OverBar.visible = true
	$OverBar2.visible = false
	tween.tween_property($OverBar, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UnderBar, "value", value, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_update_health_critical(_value: float) -> void:
	value = _value
	var tween = create_tween()
	$OverBar.visible = false
	$OverBar2.visible = true

	tween.tween_property($OverBar2, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UnderBar, "value", value, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func _on_reset() -> void:
	value = 0
	$OverBar.value = value
	$UnderBar.value = value
