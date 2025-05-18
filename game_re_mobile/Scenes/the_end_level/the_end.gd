extends Node2D

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "modulate", Color.WHITE, 3)
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "scale", Vector2(6.5,6.5), 3)
	await get_tree().create_timer(3).timeout
	$Label.text = "Well Well Well"
	await get_tree().create_timer(1).timeout
	$Label.text = "А он хорош"
	await get_tree().create_timer(1).timeout
	$Label.text = "Думаю... он достоин."
	await get_tree().create_timer(1).timeout
	$Label.text = ""
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "scale", Vector2(100,100), 4)
	get_tree().create_tween().parallel().tween_property($CharacterBody2D, "modulate", Color8(255, 255, 255, 0), 3)
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 4, 5)
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
