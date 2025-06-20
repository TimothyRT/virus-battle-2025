extends CanvasLayer


var bus_bang


func _ready():
	set_bus_anim()
	get_viewport().connect("size_changed", Callable(self, "set_bus_anim"))
	%PlayButton.pressed.connect(_on_button_pressed)
	bus_bang = load("res://assets/menus/Bus Bang.png")
	

func set_bus_anim():
	var bus_size = %BG.size / 3
	$%Bus.material.set_shader_parameter("pivot", Vector2(bus_size.x / 2.0, bus_size.y))

	var tex_rect = %BG
	var particles = %CPUParticles2D

	# Get the top-left corner position and size
	var global_pos = tex_rect.global_position
	var size = tex_rect.size

	# Calculate the emission point at 16% width and 67% height
	var offset = Vector2(size.x * 0.12, size.y * 0.67)
	particles.global_position = global_pos + offset

	# Emit particles
	particles.emitting = true
	

func _on_button_pressed():
	%Bus.texture = bus_bang
	
	if is_instance_valid(%CPUParticles2D):
		%CPUParticles2D.queue_free()
	
	Transition.switch_scene("story")
