extends RigidBody2D

@export var speed: float = 400


var publisher
var player


func _ready():
	var angle = randf_range(0.25 * PI, 0.75 * PI)
	linear_velocity = Vector2(cos(angle), -sin(angle)) * speed
	
	publisher = CollisionTypePublisher
	add_child(publisher)
	publisher.arr_wbc.append(self)
	publisher.collision_type_changed.connect(_on_collision_type_changed)
	
	if publisher.current == 1:
		z_index = 1
		#set_collision_mask_value(1, true)
		#set_collision_mask_value(2, false)
	else:
		z_index = 31
		#set_collision_mask_value(1, false)
		#set_collision_mask_value(2, true)
	
	
func _on_collision_type_changed() -> void:
	if publisher.current == 1:
		z_index = 1
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
	else:  # 2
		z_index = 31
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
	
	
func find_node_by_name(node: Node, target_name: String) -> Node:
	if node.name == target_name:
		return node
	for child in node.get_children():
		var found = find_node_by_name(child, target_name)
		if found != null:
			return found
	return null


func _process(delta: float) -> void:
	#print("WBC Mask (1): " + str(get_collision_mask_value(1)))
	#print("WBC Mask (2): " + str(get_collision_mask_value(2)))
	
	if player == null:
		for node in get_tree().root.get_children():
			if node.name == "Map":
				for _node in node.get_children():
					if _node.name == "Player":
						player = _node
						break

	if player != null:
		var direction = global_position - player.global_position
		var distance = direction.length()

		if distance > 300:
			global_position = player.global_position
			$Skin.modulate.a = 0
		else:
			$Skin.modulate.a = 1
