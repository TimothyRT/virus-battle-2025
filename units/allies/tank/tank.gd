extends Ally

class_name Tank


var initial_position = Vector2i(300, 350)
@onready var projectile = preload("res://units/allies/tank/tank_proj.tscn")


func _ready():
	damage = 100
	health = 15
	speed_x = 0
	speed_y = 0
	super._ready()
	
	#shoot()
	
	
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	global_position = initial_position
	
	
func destroy_self() -> void:
	Transition.switch_scene("game_over")


func shoot():
	var new_projectile = projectile.instantiate()
	new_projectile.position = $Marker2D.position
	add_child(new_projectile)
	
	#var timer = Timer.new()
	#timer.wait_time = 2.5
	#timer.one_shot = true
	#add_child(timer)
	#timer.timeout.connect(shoot)
	#timer.start()


func take_damage(damage: int) -> void:
	super.take_damage(damage)
	%HurtPlayer.play()
