extends Node2D

@onready var player = $Player

func _ready() -> void:
	#косметические настройки камеры, определение позиции
	#принятие сигналов
	player.healthbar.value = GlobalVar.player_health
	GlobalVar.can_move = true
	player.camera.limit_top = -1000
	Signals.dark.connect(Callable(self, "_on_dark"))
	GlobalVar.level = 4
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false


func _on_dark():
	#смена состояния игрока для катсцены
	player.state = 11
	animation()
	Signals.ended.emit()

func animation():
	#анимация света и камеры в катсцене
	$StaticBody2D/CollisionShape2D.disabled = false
	$StaticBody2D2/CollisionShape2D.disabled = false
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($light/DirectionalLight2D, "energy", 1.5, 2)
	tween.parallel().tween_property($Player, "visible", false, 5)
	player.state = 11
	tween.parallel().tween_property($light/DirectionalLight2D, "energy", 3, 5)
	tween.tween_property($light/DirectionalLight2D, "energy", 0.8, 5)
	$Label.text = "Ч...что   со  мной?"
	$Label.text = ""
	tween.tween_property($light/DirectionalLight2D, "energy", 1.5, 2)
	tween.tween_property($Player, "visible", true, 1)
	tween.tween_property($light/DirectionalLight2D, "energy", 0.8, 2)
	player.camera.position.x -= 200
	player.camera.position.y += 200

func _on_area_2d_body_entered(_body):
	#смена уровня после захода в область
	get_tree().create_tween().tween_property($light/DirectionalLight2D, "energy", 1, 1)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Level_5/level_5.tscn")
