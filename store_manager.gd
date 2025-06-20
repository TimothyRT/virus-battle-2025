extends Node


@onready var shader = preload("res://shaders/displacement.gdshader")
@onready var gameplay: Gameplay = get_tree().current_scene

var buttons = {
	"macrophage": null,
	"neutrophil": null,
	"bacteriophage": null
}

var cost = {
	"macrophage": 2,
	"neutrophil": 3,
	"bacteriophage": 1
}


func _ready() -> void:
	buttons["macrophage"] = %MacrophageButton
	buttons["macrophage"].pressed.connect(_on_macrophage_pressed)
	
	if Session.current_level in range(3, Session.last_level_available + 1):
		%NeutrophilButton.visible = true
		%NeutrophilText.visible = true
		buttons["neutrophil"] = %NeutrophilButton
		buttons["neutrophil"].pressed.connect(_on_neutrophil_pressed)
	
	if Session.current_level in range(5, Session.last_level_available + 1):
		%BacteriophageButton.visible = true
		%BacteriophageText.visible = true
		buttons["bacteriophage"] = %BacteriophageButton
		buttons["bacteriophage"].pressed.connect(_on_bacteriophage_pressed)


func refresh() -> void:
	var color = "red"
	if cost["macrophage"] <= gameplay.oxygen_count:
		color = "white"
	%MacrophageText.text = "[center][color=" + color + "]" + \
	str(cost["macrophage"]) + "[/color][/center]"
	
	color = "red"
	if cost["neutrophil"] <= gameplay.oxygen_count:
		color = "white"
	%NeutrophilText.text = "[center][color=" + color + "]" + \
	str(cost["neutrophil"]) + "[/color][/center]"
	
	color = "red"
	if cost["bacteriophage"] <= gameplay.oxygen_count:
		color = "white"
	%BacteriophageText.text = "[center][color=" + color + "]" + \
	str(cost["bacteriophage"]) + "[/color][/center]"
	
	
func _on_macrophage_pressed() -> void:
	if cost["macrophage"] <= gameplay.oxygen_count:
		gameplay.spend_oxygen(cost["macrophage"])
		_on_macrophage_button_mouse_exited()
		gameplay.place_unit("macrophage", -100, randi_range(150, 700))
		#for i in range(4):
			#await get_tree().create_timer(0.6).timeout
			#gameplay.place_unit("macrophage", -100, randi_range(150, 700))
		for i in range(4):
			gameplay.place_unit("macrophage", -100, 200 + i * 70)
	else:
		%FailPlayer.play()
	
	
func _on_neutrophil_pressed() -> void:
	if cost["neutrophil"] <= gameplay.oxygen_count:
		gameplay.spend_oxygen(cost["neutrophil"])
		_on_neutrophil_button_mouse_exited()
		gameplay.place_unit("neutrophil", -100, randi_range(150, 700))
	else:
		%FailPlayer.play()
	
	
func _on_bacteriophage_pressed() -> void:
	if cost["bacteriophage"] <= gameplay.oxygen_count:
		gameplay.spend_oxygen(cost["bacteriophage"])
		_on_bacteriophage_button_mouse_exited()
		gameplay.place_unit("bacteriophage", -100, randi_range(150, 700))
		for i in range(5):
			await get_tree().create_timer(0.4).timeout
			gameplay.place_unit("bacteriophage", -100, randi_range(150, 700))
	else:
		%FailPlayer.play()


func _on_macrophage_button_mouse_entered() -> void:
	if cost["macrophage"] <= gameplay.oxygen_count:
		var shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		buttons["macrophage"].material = shader_material


func _on_macrophage_button_mouse_exited() -> void:
	buttons["macrophage"].material = null


func _on_bacteriophage_button_mouse_entered() -> void:
	if cost["bacteriophage"] <= gameplay.oxygen_count:
		var shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		buttons["bacteriophage"].material = shader_material


func _on_bacteriophage_button_mouse_exited() -> void:
	buttons["bacteriophage"].material = null


func _on_neutrophil_button_mouse_entered() -> void:
	if cost["neutrophil"] <= gameplay.oxygen_count:
		var shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		buttons["neutrophil"].material = shader_material


func _on_neutrophil_button_mouse_exited() -> void:
	buttons["neutrophil"].material = null
