extends CanvasLayer


func _ready() -> void:
	$AudioStreamPlayer2D.play()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Transition.switch_scene("map")


func _on_timer_timeout() -> void:
	Transition.switch_scene("map")
