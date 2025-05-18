extends Node2D

func _ready() -> void:
	#анимация текста на экране при запуске игры
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 0, 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Разработано Сениным А.В", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 0, 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Совместно с КНВstudio", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 0, 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Специально для проекта по информатике", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 0, 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Название игры", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
