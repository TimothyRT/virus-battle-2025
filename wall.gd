extends StaticBody2D

class_name Wall


func _ready() -> void:
	var publisher = CollisionTypePublisher
	add_child(publisher)
	publisher.collision_type_changed.connect(_on_collision_type_changed)
	

func _process(delta: float) -> void:
	pass
	#print("(" + name + ") Wall Layer (2): " + str(get_collision_layer_value(2)))


func _on_collision_type_changed() -> void:
	pass
	#print('wall change start')
	#set_collision_layer_value(1, !get_collision_layer_value(1))
	#set_collision_layer_value(2, !get_collision_layer_value(2))
	#print('wall change finish')
