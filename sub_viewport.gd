extends SubViewport


var drawing := false
var last_pos := Vector2.ZERO


func _input(event):	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			drawing = event.pressed
			last_pos = event.global_position

	elif event is InputEventMouseMotion and drawing:
		draw_line_on_image(last_pos, event.global_position)
		last_pos = event.global_position

	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_S:
			%TextureRect.save()
		elif event.keycode == KEY_E:
			%TextureRect.canvas_array = Array()
			%TextureRect.queue_redraw()
		elif event.keycode == KEY_P:
			%TextureRect.predict()


func draw_line_on_image(from_pos: Vector2, to_pos: Vector2):
	%TextureRect.add_line(from_pos, to_pos)
