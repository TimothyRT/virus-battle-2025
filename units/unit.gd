extends CharacterBody2D

class_name Unit


@onready var gameplay: Gameplay = get_tree().current_scene

@export var damage = 0
@export var health = 0
@export var speed_x = 0
@export var speed_y = 0

var can_take_damage = true
var is_destroyed = false
var initial_velocity
@onready var hurt_shader = preload("res://units/hurt.gdshader")


func _ready():	
	if "current_state" not in get_parent():
		print("[ERROR] Not instantiated within Gameplay")
		queue_free()
	
	var shader_material = ShaderMaterial.new()
	shader_material.shader = hurt_shader
	$AnimatedSprite2D.material = shader_material


func take_damage(damage: int) -> void:
	if can_take_damage:
		health = clampi(health - damage, 0, 1000)
		can_take_damage = false
		
		$AnimatedSprite2D.material.set_shader_parameter("hurt_strength", 0.5)
	
		var timer = Timer.new()
		timer.wait_time = 0.5
		timer.one_shot = true
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
		timer.start()
		
	if health <= 0:
		destroy_self()


func destroy_self() -> void:
	fade_out(2.0)


func _on_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("hurt_strength", 0.)
	velocity = initial_velocity
	can_take_damage = true


func fade_out(duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0.0, duration)
	tween.tween_callback(Callable(self, "queue_free"))
