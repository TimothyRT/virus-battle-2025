extends CanvasLayer


@onready var gameplay: Gameplay = get_tree().current_scene
@onready var hero = get_tree().current_scene.get_node("GameArea/Tank")


func _ready():
	# Initialize a white background for our canvas
	var image = Image.create(264, 264, false, Image.FORMAT_RGBA8)
	image.fill(Color.WHITE)
	var image_texture = ImageTexture.create_from_image(image)
	%TextureRect.texture = image_texture
	
	var file = FileAccess.open("user://test_write.txt", FileAccess.WRITE)
	if file:
		file.store_line("Hello from release build!")
		file.close()
	else:
		print("Failed to open file for writing.")
		
	refresh_store()


func _on_button_pressed() -> void:
	var result = %TextureRect.predict()
	
	if result["success"] and result["prediction"] in ["WBC", "RBC"]:
		if result["prediction"] == "WBC":
			hero.shoot()
		elif result["prediction"] == "RBC":
			gameplay.add_oxygen()

	else:
		$FailPlayer.play()
		
	%TextureRect.canvas_array = Array()
	%TextureRect.queue_redraw()


func refresh_store():
	%StoreManager.refresh()
