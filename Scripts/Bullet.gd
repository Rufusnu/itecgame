extends Area2D

export (int) var E_SPEED
export (int) var E_DAMAGE

export (int) var E_TIME

var g_velocity = Vector2()
var g_knock_velo = Vector2()

func _ready():
	g_velocity = Vector2(E_SPEED, 0)
	g_knock_velo = Vector2(300, -300)
	g_velocity = g_velocity.rotated(rotation)
	if g_velocity.x < 0:
		g_knock_velo.x = -g_knock_velo.x
	$Timer.set_wait_time(E_TIME)
	$Timer.start()

func _physics_process(delta):
	position += g_velocity * delta
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body:
			if body.name == "Player":
				body.take_damage(E_DAMAGE)
				body.knock(g_knock_velo)
			die()

func die():
	queue_free()





func _on_Timer_timeout():
	die()
