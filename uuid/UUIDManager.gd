## Code written by Minoqi @2024 under the MIT license
## Documentation: https://github.com/Minoqi/minos-UUID-generator-for-godot

@tool
@icon("res://uuid/uuidIcon.svg")
extends Node
class_name UUIDManager

## Variables
var uuid : String = ""


func _enter_tree():
	if uuid == "": # Fail safe
		uuid = MinosUUIDGenerator.generate_new_UUID()


func _exit_tree():
	MinosUUIDGenerator.remove_UUID(uuid)
