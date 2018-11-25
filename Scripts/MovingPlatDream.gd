extends KinematicBody2D

var g_not_played = true

func _on_Area2D_body_entered(body):
	if body.name == "Player" and $AnimationPlayer.current_animation != "move" and g_not_played:
		$AnimationPlayer.play("move")
		g_not_played = false
