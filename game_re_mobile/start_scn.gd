extends Node2D

func _ready() -> void:
	tweene($CanvasLayer/Label, "Разработано Сениным А.В")
	await get_tree().create_timer(4).timeout
	tweene($CanvasLayer/Label, "Совместно с КНВstudio")
	await get_tree().create_timer(4).timeout
	tweene($CanvasLayer/Label, "Специально для проекта по информатике")
	await get_tree().create_timer(4).timeout
	tweene($CanvasLayer/Label, "Название игры")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

func tweene(obj, text):
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 0, 1)
	get_tree().create_tween().parallel().tween_property(obj, "text", text, 1)
	get_tree().create_tween().parallel().tween_property(obj, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property(obj, "text", "", 1)
	get_tree().create_tween().parallel().tween_property(obj, "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(2).timeout
