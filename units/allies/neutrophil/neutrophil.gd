extends Ally

class_name Neutrophil

@onready var projectile = preload("res://units/allies/neutrophil/neutrophil_proj.tscn")


func _ready():
	damage = 1
	health = 4
	speed_x = 80
	speed_y = 25
	super._ready()
	

func _physics_process(delta: float) -> void:
	var current_frame = %AnimatedSprite2D.frame
	if (current_frame not in range(8, 13)):
		super._physics_process(delta)


func shoot():
	var new_projectile = projectile.instantiate()
	new_projectile.position = %Marker2D.position
	add_child(new_projectile)


func _on_animated_sprite_2d_frame_changed() -> void:
	var current_frame = %AnimatedSprite2D.frame
	if current_frame == 12:
		shoot()
