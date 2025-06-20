extends Node


func _ready() -> void:
	$AudioStreamPlayer2D.play()


func _input(event: InputEvent) -> void:
	Session.current_level = 1
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Transition.switch_scene("cinema")
