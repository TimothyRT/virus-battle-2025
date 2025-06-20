extends CanvasLayer


@export var switch_duration = 1.0
var current_scene: String = ""


func _init() -> void:
	var regex = RegEx.new()
	regex.compile(r"res://screens/(.+)\.tscn")
	var result = regex.search(ProjectSettings.get("application/run/main_scene"))
	current_scene = result.get_string(1)


func _ready() -> void:
	if is_instance_valid($BG):
		$BG.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$BG.modulate.a = 0


func switch_scene(scene: String):	
	%BG.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property($BG, "modulate:a", 1, switch_duration / 2.0)
		
	await tween.finished
	
	get_tree().change_scene_to_file("res://screens/%s.tscn" % scene)
	get_tree().paused = false
	current_scene = scene

	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($BG, "modulate:a", 0, switch_duration / 2.0)
	%BG.mouse_filter = Control.MOUSE_FILTER_IGNORE
