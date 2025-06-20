extends CharacterBody2D

class_name TankProj


@onready var gameplay: Gameplay = get_tree().current_scene
@onready var game_area = get_tree().current_scene.get_node("GameArea")
@export var damage: int = 9999
@export var speed: float = 700.0
var closest_enemy
var closest_dist
var hit_enemy_units = []


func _ready() -> void:	
	for child in game_area.get_children():
		if child is Enemy:
			var dist = global_position.distance_to(child.global_position)
			if not closest_enemy or dist < closest_dist:
				closest_enemy = child
				closest_dist = dist
				
	if not closest_enemy:
		queue_free()
	else:
		get_parent().get_node("PewPlayer").play()


func _physics_process(delta: float) -> void:
	if game_area.current_state == Enums.GameState.ACTIVE:
		if is_instance_valid(closest_enemy):
			var direction = (closest_enemy.global_position - global_position).normalized()
			velocity = direction * speed
			
		var collision = move_and_collide(velocity * delta)
		if collision:
			var other: Enemy = collision.get_collider()
			if other not in hit_enemy_units:
				other.take_damage(damage)
				hit_enemy_units.append(other)
				fade_out(2.0)
			
				if other.health <= 0 and not other.is_destroyed:
					print("test")
					other.is_destroyed = true
					gameplay.destroy_enemy()


func fade_out(duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.0, duration)
	tween.tween_callback(Callable(self, "queue_free"))
