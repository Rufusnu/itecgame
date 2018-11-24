extends Area2D

export (int) var E_DAMAGE

var g_knock_velo = Vector2(100, -100)

func setup(facing_right):
	if !facing_right:
		g_knock_velo.x = -g_knock_velo.x

func _on_AttackArea_body_entered(body):
	if body.name != "Player":
		if body.has_method("take_damage"):
			body.take_damage(E_DAMAGE)
		if body.has_method("knock"):
			body.knock(g_knock_velo)
