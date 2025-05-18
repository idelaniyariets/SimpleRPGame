extends Node2D

@onready var player = $Player

func _ready() -> void:
	#косметические настройки камеры, определение позиции
	player.camera.limit_bottom = 10000
	GlobalVar.level = 6
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false

func _on_area_2d_body_entered(_body):
	#настройка камеры на время битвы с боссом
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$TileMapLayer5.enabled = true
	get_tree().create_tween().tween_property($TileMapLayer5, "position", Vector2.ZERO, 1)
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.play()
	player.camera.zoom.x = 0.85
	player.camera.zoom.y = 0.85
	player.position.x -= 50
	#диалог с боссом
	$CanvasLayer/AnimatedSprite2D2.visible = true
	$CanvasLayer/AnimatedSprite2D3.visible = true
	$CanvasLayer/Label.position = Vector2(603, 50)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Ну что. Ты. Смертный. Надумал вдруг сражаться с нами?", 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "Да! И я выиграю! Люди сильнее вас!", 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$CanvasLayer/Label.position = Vector2(670, 50)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Ты еще не понимаешь насколько же ты ничтожен", 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$CanvasLayer/Label.position = Vector2(790, 50)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Попоробуй для начала победить меня!", 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	await get_tree().create_timer(1).timeout
	$CanvasLayer/AnimatedSprite2D2.visible = false
	$CanvasLayer/AnimatedSprite2D3.visible = false
	#конец диалога
	GlobalVar.attack = true
	await get_tree().create_timer(0.2).timeout


func _on_area_2d_2_body_entered(_body):
	#анимация перехода на следующую локацию
	GlobalVar.can_move = false
	get_tree().create_tween().tween_property($DirectionalLight2D, 'energy', 16, 5)
	await get_tree().create_timer(4.5).timeout
	GlobalVar.can_move =  true
	get_tree().change_scene_to_file("res://Scenes/level_7/level_7.tscn")
