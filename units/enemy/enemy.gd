extends Unit

class_name Enemy


@onready var hero = get_tree().current_scene.get_node("GameArea/Tank")


func _ready() -> void:
	super._ready()
	initial_velocity = Vector2.LEFT * speed_x
	velocity = initial_velocity
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, false)
	$AnimatedSprite2D.flip_h = true


func _physics_process(delta: float) -> void:
	if get_parent().current_state == Enums.GameState.ACTIVE:
		if global_position.x <= 1000:
			var direction = (hero.global_position - global_position).normalized()
			velocity.x = direction.x * speed_x
			velocity.y = direction.y * speed_y
		else:
			velocity = initial_velocity
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			var other: Ally = collision.get_collider()
			velocity = velocity.bounce(collision.get_normal() * 96.0)
			take_damage(other.damage)
			other.take_damage(damage)
			
			if health <= 0 and not is_destroyed:
				print("test")
				is_destroyed = true
				gameplay.destroy_enemy()
				other.kill_enemy(self)
