extends StaticBody2D

var g_disable_collision = false

func _physics_process(delta):
	$CollisionShape2D.disabled = g_disable_collision

func interact():
	print("interact")
	g_disable_collision = !g_disable_collision

