extends CenterContainer


signal update_health(amount)
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
	connect("reset", Callable(self, "_on_reset"))


func _on_update_health(_value: float) -> void:
	value = _value
	var tween = create_tween()
	tween.tween_property($OverBar, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UnderBar, "value", value, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_reset() -> void:
	value = 0
	$OverBar.value = value
	$UnderBar.value = value
