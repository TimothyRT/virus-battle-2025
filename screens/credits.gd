extends Node

var s = 0


func _ready() -> void:
	$CanvasLayer.visible = true
	$CanvasLayer2.visible = false
	$AudioStreamPlayer2D.play()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			match s:
				0:
					$CanvasLayer.visible = false
					$CanvasLayer2.visible = true
					s = 1
				1:
					$CanvasLayer2.visible = false
					s = 2
				2:
					Transition.switch_scene("cinema")
