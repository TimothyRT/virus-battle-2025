extends CanvasLayer


func _ready() -> void:
	$LevelLabel.text = "[center][color=black]Level " + str(Session.current_level) + "[/color][/center]"


func _on_timer_timeout() -> void:
	Transition.switch_scene("gameplay")
