extends Area2D

export (int) var E_DAMAGE

var g_knock_velo = Vector2(100, -100)

func setup(dist, facing_right):
	
	if !facing_right:
		g_knock_velo.x = -g_knock_velo.x
		dist = -dist
	position.x += dist
	

func _on_AttackArea_body_entered(body):
	if body.name != "Player":
		if body.has_method("take_damage"):
			body.take_damage(E_DAMAGE)
		if body.has_method("knock"):
			body.knock(g_knock_velo)


func _on_Timer_timeout():
	queue_free()


func _on_StartTimer_timeout():
	$CollisionShape2D.disabled = false
	$Timer.start()
