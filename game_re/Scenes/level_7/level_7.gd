extends Node2D

@onready var player = $Player

var memories_preload = preload("res://Scenes/history_level/history_level.tscn").instantiate()#сосзание переменной для катсцены

func _ready() -> void:
	#настройки камеры, определение позиции
	player.camera.limit_bottom = 10000
	GlobalVar.level = 7
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false

func _on_area_2d_body_entered(_body):
	#падение игрока вниз из камеры
	get_tree().create_tween().tween_property($Light/DirectionalLight2D, "energy", 2, 1)
	$TileMapLayer3.enabled = true
	await get_tree().create_timer(1).timeout
	GlobalVar.can_move = true
	$TileMapLayer3.enabled = false
	$TileMapLayer2.position.y = 10000
	$Player.camera.limit_bottom = 1000000
	await get_tree().create_timer(1.35).timeout
	GlobalVar.can_move = true
	$TileMapLayer3.enabled = true

func _on_area_2d_2_body_entered(_body):
	#дилог персонажа с самим собой
	$"Triggers n walls/Area2D2/CollisionShape2D".set_deferred("disabled", true)
	get_tree().create_tween().tween_property($Light/DirectionalLight2D, "energy", 0.4, 1)
	await get_tree().create_timer(2).timeout
	$CanvasLayer/AnimatedSprite2D.visible = true
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "И опять я куда то влип...", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Иду по какому то коридору...", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "В каком-то подземелье...", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Зачем мне все это...", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "И кто только этот коридор делал!?", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	$CanvasLayer/AnimatedSprite2D.visible = false
	$"Triggers n walls/Area2D2/CollisionShape2D".disabled = false

func _on_area_2d_3_body_entered(_body):
	#анимация агиса сверху
	GlobalVar.can_move = false
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "modulate", Color8(255, 255, 255, 255), 0.5)
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "scale", Vector2(100, 100), 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().create_tween().tween_property($CharacterBody2D, "modulate", Color8(255, 255, 255, 0), 0.5)
	await get_tree().create_timer(0.5).timeout
	$Player.position = Vector2(1682, 580)

func _on_area_2d_7_body_entered(_body):
	#остановка игрока для катсцены
	GlobalVar.can_move = false

func _on_area_2d_8_body_entered(_body) -> void:
	#анимация пола во время разговора с боссом
	player.camera.zoom.x = 1
	player.camera.zoom.y = 1
	get_tree().create_tween().tween_property($TileMapLayer5, "position", Vector2.ZERO, 2)
	$"Triggers n walls/Area2D8/CollisionShape2D".set_deferred("disabled", true)
	GlobalVar.can_move = false
	get_tree().create_tween().tween_property($TileMapLayer4, "position", Vector2(self.position.x, self.position.y - 150), 0.5)
	await get_tree().create_timer(18).timeout
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.play()
	get_tree().create_tween().tween_property($TileMapLayer4, "position", Vector2(self.position.x - 5000, self.position.y - 50), 0.2)
	GlobalVar.can_move = true

func _on_area_2d_9_body_entered(_body):
	#смена уровня
	get_tree().change_scene_to_file("res://Scenes/level_8/level_8_final.tscn")

func _on_area_2d_10_body_entered(_body):
	#катсцена городом анимация
	GlobalVar.can_move = false
	$"Triggers n walls/Area2D10/CollisionShape2D".set_deferred("disabled", true)
	get_tree().create_tween().parallel().tween_property($Player.camera, "zoom", Vector2(10, 10), 0.5)
	get_tree().create_tween().parallel().tween_property($Light/DirectionalLight2D, "color", Color8(0, 0, 0, 0), 0.5)
	await get_tree().create_timer(0.6).timeout
	$TileMapLayer.visible = false
	$Player.visible = false
	$collactable_health_poison2.visible = false
	$CharacterBody2D4.visible = false
	get_tree().create_tween().parallel().tween_property($Player.camera, "zoom", Vector2(0.9, 0.9), 0.5)
	get_tree().create_tween().parallel().tween_property($Light/DirectionalLight2D, "color", Color8(255, 255, 255, 255), 0.5)
	await get_tree().create_timer(0.5).timeout
	memories_preload.z_index = -10
	memories_preload.top_level = true
	memories_preload.scale = Vector2(1.5, 1.5)
	memories_preload.position = Vector2(6400, 60)
	$".".add_child(memories_preload)
	await get_tree().create_timer(3).timeout
	$".".remove_child(memories_preload)
	$CanvasLayer/AnimatedSprite2D.visible = true
	player.camera.zoom.x = 1
	player.camera.zoom.y = 1
	$TileMapLayer.visible = true
	$Player.visible = true
	$collactable_health_poison2.visible = true
	$CharacterBody2D4.visible = true
	#диалог с самим собой
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Так вот что происхдит в деревне", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 0.3)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 0.3)
	await get_tree().create_timer(0.3).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Я должен все исправить!", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 0.3)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 0.3)
	GlobalVar.can_move = true
	$CanvasLayer/AnimatedSprite2D.visible = false
