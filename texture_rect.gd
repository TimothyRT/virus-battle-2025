extends TextureRect

var canvas_array: Array = Array()

var pencil_clr := Color.BLACK
var pencil_size := 10

var abs_runtime_path: String
var abs_vmfb_path: String


const max_tries: int = 4


@export var uuidNode : UUIDManager


func _ready() -> void:
	if OS.has_feature("editor"):  # editor build for development; use res://
		print('Development Build')
		abs_runtime_path = ProjectSettings.globalize_path("res://iree/iree/_runtime_libs/iree-run-module.exe")
		abs_vmfb_path = ProjectSettings.globalize_path("res://iree/model.vulkan.vmfb")
	else:  # production build; use path relative to our executable in the file system
		print('Production Build')
		abs_runtime_path = OS.get_executable_path().get_base_dir().path_join("iree/iree/_runtime_libs/iree-run-module.exe")
		abs_vmfb_path = OS.get_executable_path().get_base_dir().path_join("iree/model.vulkan.vmfb")
		print("abs_runtime_path: " + abs_runtime_path)
		

func add_line(from_pos: Vector2, to_pos: Vector2) -> void:
	canvas_array.append([from_pos, to_pos])
	queue_redraw()


func save() -> void:
	uuidNode = MinosUUIDGenerator.create_new_uuid(self)
	
	var img = get_viewport().get_texture().get_image()
	img.resize(28, 28, 1)
	img.save_png("user://" + uuidNode.uuid + ".png")


func _draw() -> void:
	for row in canvas_array:
		draw_line(row[0], row[1], pencil_clr, pencil_size, true)
		# use true for antialiasing in order to keep the line smooth


func predict() -> Dictionary:
	var img = get_viewport().get_texture().get_image()
	img.resize(28, 28, 1)
	img.convert(Image.FORMAT_L8)  # convert to grayscale (1 byte per pixel)

	var grayscale_values: PackedFloat32Array = PackedFloat32Array()
	# Each value will be a float between 0.0 and 1.0, as expected by our model

	for y in range(28):
		for x in range(28):
			var color = img.get_pixel(x, y).r  # because grayscale, r = g = b
			grayscale_values.append(color)
	
	var filename: String = Npy.create_npy(grayscale_values, [28, 28])
	var abs_npy_path = ProjectSettings.globalize_path("user://" + filename + ".npy")
	
	for i in range(max_tries):
		var output = []
		var exit_code = OS.execute(
			abs_runtime_path,
			[
				"--device=vulkan",
				"--module=" + abs_vmfb_path,
				"--function=main",
				"--input=@" + abs_npy_path
			],
			output,
			true)
		
		#print("IREE exit code:", exit_code)
		#print("IREE output:", output)
		
		var result: String = output[0]
		var regex = RegEx.new()
		regex.compile(r'[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?')

		var matches = regex.search_all(result)
		var dirty_scores = []
		for match in matches:
			dirty_scores.append(float(match.get_string()))
		
		var scores = dirty_scores.slice(
			dirty_scores.size() - DoodleLabels.size(),
			dirty_scores.size())
		
		var prediction: String = DoodleLabels.labels()[scores.find(scores.max())]
		%Label.text = "Prediction: " + prediction + "; result: " + str(output)
		print("Output: " + str(output[0]))
		print("Prediction: " + prediction)
		
		# Lakban for when the model fails to make a prediction
		if scores.max() >= 0.1:
			return {
				'success': true,
				'prediction': prediction
			}
	
	return {
		'success': false,
		'prediction': ""
	}
	
