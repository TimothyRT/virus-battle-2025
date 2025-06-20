extends Enemy

class_name Dirt


var init_time


func _ready():
	init_time = Time.get_unix_time_from_system()
	damage = 1
	health = 2
	speed_x = 45
	speed_y = 90
	super._ready()
	
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	position.y += sin(Time.get_unix_time_from_system() - init_time)
