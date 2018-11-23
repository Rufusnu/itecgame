extends Node2D

func play(anim):
	
	$Sprite/AnimationPlayer.play(anim)

func _on_Timer_timeout():
	queue_free()
