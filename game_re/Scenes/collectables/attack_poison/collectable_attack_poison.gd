extends CharacterBody2D#зелье урона

func _on_area_2d_body_entered(_body):
	#проверка на соответствие локации и урона и начисление 20% от текущего урона
	if GlobalVar.level == 6 and GlobalVar.player_damage<36 and GlobalVar.night_player_damage<43:
		GlobalVar.player_damage += int(0.2*GlobalVar.player_damage)
		GlobalVar.night_player_damage += int(0.2*GlobalVar.player_damage)
		print(GlobalVar.player_damage)
	elif GlobalVar.level == 7 and GlobalVar.player_damage<51 and GlobalVar.night_player_damage<61:
		GlobalVar.player_damage += int(0.2*GlobalVar.player_damage)
		GlobalVar.night_player_damage += int(0.2*GlobalVar.player_damage)
		print(GlobalVar.player_damage)
	else:
		print_debug("you've reached buffs limit")

	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", Vector2(self.position.x, self.position.y - 40), 0.5)
	tween.parallel().tween_property(self, "modulate", Color8(255, 255, 255, 0), 0.5)
	await get_tree().create_timer(0.5).timeout
	queue_free()
	#$AnimatedSprite2D.stop()
	#$AnimationPlayer.play("RESET")
