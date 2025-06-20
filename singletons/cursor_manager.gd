extends Node

var basic = preload("res://assets/cursor/Cursor - Basic.png")
var exclamation = preload("res://assets/cursor/Cursor - Exclamation.png")

func _ready():
	set_basic()

func set_basic():
	Input.set_custom_mouse_cursor(basic)

func set_exclamation():
	Input.set_custom_mouse_cursor(exclamation)

func reset_cursor():
	Input.set_custom_mouse_cursor(null)
