extends CharacterBody2D

@onready var player = $"../Player"

func _on_area_2d_body_entered(_body):
	if GlobalVar.level == 2 and GlobalVar.player_health_max_value < 120:
		GlobalVar.player_health_max_value += int(0.2*GlobalVar.player_health_max_value)
	elif GlobalVar.level == 2:
		print_debug("developer is kind. you can restore health, but you've reached buffs limit")
	
	if GlobalVar.level == 6 and GlobalVar.player_health_max_value < 511:
		GlobalVar.player_health_max_value += int(2*GlobalVar.player_health_max_value)
	elif GlobalVar.level == 6:
		print_debug("developer is kind. you can restore health, but you've reached buffs limit")
	
	if GlobalVar.level == 7 and GlobalVar.player_health_max_value < 355:
		GlobalVar.player_health_max_value += int(2*GlobalVar.player_health_max_value)
	elif GlobalVar.level == 7:
		print_debug("developer is kind. you can restore health, but you've reached buffs limit")
	
	if GlobalVar.player_health < 0.8*GlobalVar.player_health_max_value and GlobalVar.player_health >= 0.5*GlobalVar.player_health_max_value:
		GlobalVar.player_health += 0.3*GlobalVar.player_health
	elif GlobalVar.player_health >= 0.8*GlobalVar.player_health_max_value:
		GlobalVar.player_health = GlobalVar.player_health_max_value
	elif GlobalVar.player_health == GlobalVar.player_health_max_value:
		pass
	elif GlobalVar.player_health < 0.5*GlobalVar.player_health_max_value:
		GlobalVar.player_health += 0.3*GlobalVar.player_health_max_value
		
	print (GlobalVar.player_health)
	print (GlobalVar.player_health_max_value)
	print(player.healthbar.max_value)
	print(player.healthbar.value)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", Vector2(self.position.x, self.position.y - 40), 0.5)
	tween.parallel().tween_property(self, "modulate", Color8(255, 255, 255, 0), 0.5)
	await get_tree().create_timer(0.5).timeout
	queue_free()
