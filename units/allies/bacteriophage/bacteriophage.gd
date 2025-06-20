extends Ally

class_name Bacteriophage

@onready var bacteriophage = preload("res://units/allies/bacteriophage/bacteriophage.tscn")
@onready var game_area = get_tree().current_scene.get_node("GameArea")


func _ready():
	damage = 2
	health = 7
	speed_x = 130
	speed_y = 25
	super._ready()


func kill_enemy(enemy: Enemy) -> void:
	super.kill_enemy(enemy)
	
	var new_bacteriophage = bacteriophage.instantiate()
	new_bacteriophage.global_position.x = global_position.x + randi_range(-15, 10)
	new_bacteriophage.global_position.y = global_position.y + randi_range(-10, 15)
	game_area.add_child(new_bacteriophage)
