extends Area2D

export (String) var E_TEXT

func _ready():
	$Label.text = E_TEXT
	visible = false

func interact():
	if visible and ($Label.visible_characters >= E_TEXT.length() or $Label.visible_characters == -1):
		$Label.visible_characters = 0
		visible = false
		$Timer.stop()
	elif visible:
		$Label.visible_characters = -1
		$Timer.stop()
	else:
		visible = true
		$Timer.start()

func _on_Timer_timeout():
	$Label.visible_characters += 1
	

func _on_DialogInteract_area_exited(area):
	print(area.name)
	if area.get_parent().name == "Player":
		visible = false
		$Label.visible_characters = 0
