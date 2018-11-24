extends Area2D




func _on_MakeFall_body_entered(body):
	if body.name == "Player":
		body.set_collision_mask_bit(0, 0)

