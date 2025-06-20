extends Node


signal collision_type_changed()


var current = 1
var arr_wbc = []


func emit() -> void:
	if current == 2: current = 1
	elif current == 1: current = 2
	emit_signal("collision_type_changed")
