extends CharacterBody2D

class_name Player


var can_swap: bool = true


@export var speed := 500  # movement speed (pixels per second)


func _physics_process(delta):
	#var input_vector = Vector2(
		#int(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")),
		#int(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	#).normalized()
#
	#velocity = input_vector * speed
	#move_and_slide()
	
	var collision
	var mouse_position = get_global_mouse_position()
	var distance = global_position.distance_to(mouse_position)
	if distance > 150:
		var direction = (mouse_position - global_position).normalized()
		velocity = direction * speed
		collision = move_and_collide(velocity * delta)
		#CursorManager.set_basic()
	else:
		collision = null
		#CursorManager.set_exclamation()
		
	if collision and can_swap:
		if collision.get_collider().name in ["Portal Kanan Atas", "Portal Kiri Bawah"] and can_swap:
			can_swap = false
			
			print('0w0')
			
			match collision.get_collider().name:
				"Portal Kanan Atas":
					global_position = Vector2(-200, -1656)
					z_index = 31
					set_collision_mask_value(1, false)
					set_collision_mask_value(2, true)
					CollisionTypePublisher.emit()
				"Portal Kiri Bawah":
					print('uwu')
					global_position = Vector2(-512, -1973)
					z_index = 1
					set_collision_mask_value(1, true)
					set_collision_mask_value(2, false)
					CollisionTypePublisher.emit()
					
			$Timer.start()

func _input(event: InputEvent) -> void:
	pass
	#if event is InputEventKey and event.pressed and event.keycode == KEY_1:
		#swap()


func _on_timer_timeout() -> void:
	can_swap = true
