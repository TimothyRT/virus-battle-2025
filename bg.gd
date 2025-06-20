extends Sprite2D


func _ready():
	var img = Image.create(1, 1, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.043, 0.137, 0.286))  # White color
	var tex = ImageTexture.create_from_image(img)
	texture = tex
	
	resize_bg()
	get_viewport().connect("size_changed", Callable(self, "resize_bg"))


func resize_bg():
	# Stretch background to fill the current screen size
	
	var screen_size = get_viewport_rect().size
	var texture_size = texture.get_size()
	scale = screen_size / texture_size
