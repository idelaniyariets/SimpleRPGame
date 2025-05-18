extends CharacterBody2D #зелье здоровья

@onready var player = $"../Player"

func _on_area_2d_body_entered(_body):
	#рассчет количества здоровья, которое должно быть на уровне 2, 6, 7
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
	#рассчет прибавления здоровья 20% от максимального запаса здоровья и пополнение на 30% от текущего здоровья
	#или на 30% от максимального здоровья или до максимального здоровья
	if GlobalVar.player_health < 0.8*GlobalVar.player_health_max_value and GlobalVar.player_health >= 0.5*GlobalVar.player_health_max_value:
		GlobalVar.player_health += 0.3*GlobalVar.player_health
	elif GlobalVar.player_health >= 0.8*GlobalVar.player_health_max_value:
		GlobalVar.player_health = GlobalVar.player_health_max_value
	elif GlobalVar.player_health == GlobalVar.player_health_max_value:
		pass
	elif GlobalVar.player_health < 0.5*GlobalVar.player_health_max_value:
		GlobalVar.player_health += 0.3*GlobalVar.player_health_max_value
	#анимация подбора зелья
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", Vector2(self.position.x, self.position.y - 40), 0.5)
	tween.parallel().tween_property(self, "modulate", Color8(255, 255, 255, 0), 0.5)
	await get_tree().create_timer(0.5).timeout
	queue_free()
