extends Area2D



func _on_BossTrigger_body_entered(body):
	if body.name == "Player" and get_parent().get_node("Boss/AnimationPlayer").current_animation != "move":
		get_parent().get_node("Boss/AnimationPlayer").play("move")
