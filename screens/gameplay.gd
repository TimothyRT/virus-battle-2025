extends Node

class_name Gameplay


@onready var d_unit = {
	"aspergillus": preload("res://units/enemy/aspergillus/aspergillus.tscn"),
	"dirt": preload("res://units/enemy/dirt/dirt.tscn"),
	"dust": preload("res://units/enemy/dust/dust.tscn"),
	"pseudomonas": preload("res://units/enemy/pseudomonas/pseudomonas.tscn"),
	"staphylococcus": preload("res://units/enemy/staphylococcus/staphylococcus.tscn"),
	"streptococcus": preload("res://units/enemy/streptococcus/streptococcus.tscn"),
	"macrophage": preload("res://units/allies/macrophage/macrophage.tscn"),
	"neutrophil": preload("res://units/allies/neutrophil/neutrophil.tscn"),
	"bacteriophage": preload("res://units/allies/bacteriophage/bacteriophage.tscn")
}
@onready var hero = $GameArea/Tank
var oxygen_count = 0
var enemy_count = 0
var wave_count = 0
var wave_max: int


func _ready() -> void:
	hero.global_position.x = hero.initial_position.x
	hero.global_position.y = hero.initial_position.y
	
	_set_max_waves()
	
	%WaveTimer.start()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_0:
			Session.current_level = 6
			Transition.switch_scene("gameplay")
			
	#if event is InputEventKey and event.pressed:
		#match event.keycode:
			#KEY_1:
				#place_unit("macrophage", 100, randi_range(150, 700))
			#KEY_2:
				#place_unit("neutrophil", 100, randi_range(150, 700))
			#KEY_3:
				#place_unit("bacteriophage", 100, randi_range(150, 700))
			#KEY_5:
				#place_unit("streptococcus", 1920 - 100, randi_range(150, 700))
			#KEY_6:
				#place_unit("pseudomonas", 1920 - 100, randi_range(150, 700))
			#KEY_7:
				#place_unit("dust", 1920 - 100, randi_range(150, 700))
			#KEY_8:
				#place_unit("dirt", 1920 - 100, randi_range(150, 700))
			#KEY_9:
				#place_unit("aspergillus", 1920 - 100, randi_range(150, 700))
			#KEY_0:
				#place_unit("staphylococcus", 1920 - 100, randi_range(150, 700))
	#
	#elif event is InputEventMouseMotion:
		#$OverlayCanvas/DebugText.text = "Pos: " + str(event.global_position)


func _process(delta: float) -> void:
	%HealthText.text = "[color=black][center] x" + str(%Tank.health) + "[/center][/color]"
	%OxygenText.text = "[color=black][center] x" + str(oxygen_count) + "[/center][/color]"
	
	
func add_oxygen():
	oxygen_count += 1
	%OxygenPlayer.play()
	$PaintCanvas2D.refresh_store()
	
	
func spend_oxygen(oxygen: int):
	oxygen_count -= oxygen
	%PurchasePlayer.play()
	$PaintCanvas2D.refresh_store()


func place_unit(unit_name: String, x: int, y: int) -> void:
	var x_noised = x + randi_range(-30, 30)
	
	if unit_name in ["aspergillus", "dirt", "dust", "pseudomonas", "staphylococcus", "streptococcus"]:
		y += 200
		enemy_count += 1
		
	var new_unit = d_unit[unit_name].instantiate()
	new_unit.global_position.x = x_noised
	new_unit.global_position.y = y
	%GameArea.add_child(new_unit)
	
	update_enemy_debug()


func destroy_enemy() -> void:
	enemy_count -= 1
	
	if wave_count == wave_max and enemy_count <= 0:
		await get_tree().create_timer(2.0).timeout
		if Session.current_level == Session.last_level_available:
			Transition.switch_scene("credits")
		else:
			Transition.switch_scene("level_end")
	
	update_enemy_debug()
	
	
func update_enemy_debug():
	%EnemyDebugText.text = "[color=black] Wave: " + str(wave_count) + "; enemy: " + str(enemy_count) + "[/color]"


func _set_max_waves():
	match Session.current_level:
		1:
			wave_max = 8
		2:
			wave_max = 14
		3:
			wave_max = 18
		4:
			wave_max = 22
		5:
			wave_max = 24
		6:
			wave_max = 26


func spawn_enemy_wave(current_wave_count: int) -> void:
	match Session.current_level:
		1:
			if wave_count < 5:
				var random_number = randi_range(1, 3)
				match random_number:
					1:
						for i in range(randi_range(6, 8)):
							place_unit("staphylococcus", 1920 - 100, randi_range(150, 700))
					2:
						for i in range(6):
							place_unit("staphylococcus", 1920 - 100, randi_range(250, 600))
					3:
						for i in range(2):
							place_unit("aspergillus", 1920 - 100, randi_range(150, 700))
			else:
				for i in range(5):
					place_unit("aspergillus", 1920 - 100, 300 + i * 50)
		2:
			if wave_count < 12:
				var random_number = randi_range(1, 3)
				match random_number:
					1:
						for i in range(randi_range(4, 10)):
							place_unit("dirt", 1920 - 100, randi_range(150, 700))
					2:
						for i in range(6):
							place_unit("dirt", 1920 - 100, randi_range(250, 600))
					3:
						for i in range(2):
							place_unit("staphylococcus", 1920 - 100, randi_range(150, 700))
			else:
				for i in range(5):
					place_unit("aspergillus", 1920 - 100, 300 + i * 50)
		3:
			if wave_count < 15:
				var random_number = randi_range(1, 3)
				match random_number:
					1:
						for i in range(randi_range(4, 10)):
							place_unit("staphylococcus", 1920 - 100, randi_range(150, 700))
					2:
						for i in range(6):
							place_unit("dust", 1920 - 100, randi_range(250, 600))
					3:
						for i in range(randi_range(3, 6)):
							place_unit("dust", 1920 - 100, randi_range(150, 700))
			elif wave_count < wave_max:
				for i in range(5):
					place_unit("dirt", 1920 - 100, 300 + i * 50)
			else:
				place_unit("streptococcus", 1920 - 100, randi_range(250, 600))
		4:
			var random_number = randi_range(1, 4)
			match random_number:
				1:
					for i in range(randi_range(3, 4)):
						place_unit("streptococcus", 1920 - 100, randi_range(150, 700))
				2:
					for i in range(8):
						place_unit("aspergillus", 1920 - 100, randi_range(250, 600))
				3:
					for i in range(randi_range(3, 6)):
						place_unit("aspergillus", 1920 - 100, randi_range(150, 700))
				4:
					for i in range(randi_range(3, 4)):
						place_unit("staphylococcus", 1920 - 100, randi_range(150, 700))
		5:
			if wave_count < 21:
				var random_number = randi_range(1, 3)
				match random_number:
					1:
						for i in range(randi_range(3, 4)):
							place_unit("streptococcus", 1920 - 100, randi_range(150, 700))
					2:
						for i in range(8):
							place_unit("staphylococcus", 1920 - 100, randi_range(250, 600))
					3:
						for i in range(randi_range(3, 6)):
							place_unit("dirt", 1920 - 100, randi_range(150, 700))
			elif wave_count < wave_max:
				for i in range(6):
					place_unit("aspergillus", 1920 - 100, 300 + i * 50)
			else:
				place_unit("streptococcus", 1920 - 100, randi_range(250, 600))
		6:
			if wave_count < 22:
				var random_number = randi_range(1, 3)
				match random_number:
					1:
						for i in range(randi_range(4, 10)):
							place_unit("dust", 1920 - 100, randi_range(150, 700))
					2:
						for i in range(6):
							place_unit("dirt", 1920 - 100, randi_range(250, 600))
					3:
						for i in range(randi_range(2, 4)):
							place_unit("streptococcus", 1920 - 100, randi_range(150, 700))
			elif wave_count < wave_max:
				place_unit("pseudomonas", 1920 - 100, randi_range(150, 700))
			else:
				for i in range(2):
					place_unit("pseudomonas", 1920 - 100, randi_range(250, 600))


func _on_wave_timer_timeout() -> void:
	if wave_count < wave_max:
		spawn_enemy_wave(wave_count)
		wave_count += 1


func _on_music_player_finished() -> void:
	%MusicPlayer.play()
