extends KinematicBody2D

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
	var body = move_and_collide(g_velocity * delta)
	if body:
		if body.collider.name == "Player":
			body.collider.take_damage(E_DAMAGE)
			body.collider.knock(g_knock_velo)
		die()

func die():
	queue_free()



