extends CharacterBody2D

class_name NeutrophilProj


@onready var gameplay: Gameplay = get_tree().current_scene
@onready var game_area = get_tree().current_scene.get_node("GameArea")
@export var damage: int = 9
@export var speed: float = 400.0
var closest_enemy
var closest_dist
var direction
var hit_enemy_units = []


func _ready() -> void:	
	for child in game_area.get_children():
		if child is Enemy and child.global_position.x >= global_position.x:
			var dist = global_position.distance_to(child.global_position)
			if not closest_enemy or dist < closest_dist:
				closest_enemy = child
				closest_dist = dist
	
	if is_instance_valid(closest_enemy):
		direction = (closest_enemy.global_position - global_position).normalized()
	else:
		direction = Vector2.RIGHT
	%Sprite2D.rotation = direction.angle()


func _physics_process(delta: float) -> void:
	if game_area.current_state == Enums.GameState.ACTIVE:
		velocity = direction * speed
			
		var collision = move_and_collide(velocity * delta)
		if collision:
			var other: Enemy = collision.get_collider()
			if other not in hit_enemy_units:
				other.take_damage(damage)
				hit_enemy_units.append(other)
				fade_out(0.2)
				
				if other.health <= 0 and not other.is_destroyed:
					print("test")
					other.is_destroyed = true
					gameplay.destroy_enemy()


func fade_out(duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.0, duration)
	tween.tween_callback(Callable(self, "queue_free"))


func _on_timer_timeout() -> void:
	fade_out(0.2)
