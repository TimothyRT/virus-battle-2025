extends Unit

class_name Ally


func _ready() -> void:
	super._ready()
	initial_velocity = Vector2.RIGHT * speed_x
	velocity = initial_velocity
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)


func _physics_process(delta: float) -> void:
	if get_parent().current_state == Enums.GameState.ACTIVE:
		if velocity.x <= 5.0:
			velocity = initial_velocity
			
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal() * 44.0)


func kill_enemy(enemy: Enemy) -> void:
	pass
