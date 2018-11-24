extends Area2D

export (String) var E_TEXT

func _ready():
	$Label.text = E_TEXT
	$ColorRect.visible = false
	$Label.visible = false
	$Sprite.visible = false

func interact():
	if $Label.visible and ($Label.visible_characters >= E_TEXT.length() or $Label.visible_characters == -1):
		$Label.visible_characters = 0
		$ColorRect.visible = false
		$Label.visible = false
		$Timer.stop()
	elif $Label.visible:
		$Label.visible_characters = -1
		$Timer.stop()
	else:
		$ColorRect.visible = true
		$Label.visible = true
		$Timer.start()

func _on_Timer_timeout():
	$Label.visible_characters += 1
	

func _on_DialogInteract_area_exited(area):
	if area.get_parent().name == "Player":
		$ColorRect.visible = false
		$Label.visible = false
		$Label.visible_characters = 0
		$Timer.stop()
		$Sprite.visible = false


func _on_DialogInteract_area_entered(area):
	if area.get_parent().name == "Player":
		$Sprite.visible = true
