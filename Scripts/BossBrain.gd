extends StaticBody2D

signal win()


export (int) var E_HEALTH

var g_hp

func _ready():
	connect("win", get_tree().get_root().get_node("MainScene"), "win")
	g_hp = E_HEALTH
	

func take_damage(damage):
	g_hp -= damage
	if g_hp <= 0:
		emit_signal("win")
	get_parent().get_node("BossHealth").value = g_hp