extends CanvasLayer


func _ready():
	var player = $VideoStreamPlayer
	player.stream = load("res://cinema/vid.ogv")
	player.connect("finished", _on_video_finished)
	player.play()


func _on_video_finished():
	print("Video finished!")
	Transition.switch_scene("tutorial")
