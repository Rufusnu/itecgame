extends StaticBody2D

export (int) var E_HEALTH

var g_hp

func _ready():
	g_hp = E_HEALTH

func take_damage(damage):
	g_hp -= damage
	if g_hp <= 0:
		queue_free()