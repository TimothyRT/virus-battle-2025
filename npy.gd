extends Node

class_name Npy

#const runtime_path = "res://iree/iree/_runtime_libs/iree-run-module.exe"
#var abs_runtime_path = ProjectSettings.globalize_path(runtime_path)


static func create_npy(data: PackedFloat32Array, shape: Array) -> String:
	var filename: String = "temp"
	
	if shape.size() != 2:
		print("[ERROR] Shape must be [height, width]")
		return ""

	var file = FileAccess.open("user://" + filename + ".npy", FileAccess.WRITE)
	if file == null:
		print("[ERROR] Failed to open file")
		return ""
	
	# === 1. MAGIC STRING AND VERSION ===
	var magic := PackedByteArray([0x93]) + "NUMPY".to_utf8_buffer()
	file.store_buffer(magic)
	file.store_8(1)  # major version
	file.store_8(0)  # minor version

	# === 2. HEADER ===
	var h = str(shape[0])
	var w = str(shape[1])
	var shape_str: String = "(1, " + h + ", " + w + ", 1)"
	var header_dict := "{'descr': '<f4', 'fortran_order': False, 'shape': " + shape_str + ", }"
	var pad_len := (16 - (10 + header_dict.length()) % 16) % 16
	var full_header := header_dict + " ".repeat(pad_len) + "\n"
	var header_len := full_header.to_utf8_buffer().size()

	file.store_16(header_len)
	file.store_buffer(full_header.to_utf8_buffer())

	# === 3. DATA ===
	for f in data:
		file.store_float(f)

	file.flush()
	file.close()
	print("Saved: user://" + filename + ".npy")

	return filename
	
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_0:
			#var output = []
			##var exit_code = OS.execute(
				##"CMD.exe", ["/C", 'echo "Hello"'],
				##output, false, false)
				#
			#var exit_code = OS.execute(
				#abs_runtime_path,
				#[
					#"--device=vulkan",
					#"--module=model.vulkan.vmfb",
					#"--function=main",
					#"--input=@input.npy"
				#],
				#output,
				#true)
				#
			#print("Exit code:", exit_code)
			#print("Output:", output)
