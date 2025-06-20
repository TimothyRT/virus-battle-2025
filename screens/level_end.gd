extends Node


func _ready() -> void:
	%LevelXComplete.text = "[color=black]Level " + str(Session.current_level) + " tuntas![/color]"
	Session.current_level += 1
	$AudioStreamPlayer2D.play()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Transition.switch_scene("gameplay")
