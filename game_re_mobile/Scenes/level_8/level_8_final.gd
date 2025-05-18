extends Node2D


func _ready() -> void:
	$CanvasLayer/AnimatedSprite2D.visible = true
	
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "Слава нашему герою!", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "Ура! Ура! Ура!", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 255), 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "text", "", 1)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/Label2, "modulate", Color8(255, 255, 255, 0), 1)
	await get_tree().create_timer(1).timeout
	
	$CanvasLayer/AnimatedSprite2D2.visible = false
	$CanvasLayer/AnimatedSprite2D.visible = false
	
	await get_tree().create_timer(1).timeout
	get_tree().create_tween().parallel().tween_property($DirectionalLight2D, "energy", 3, 1)
	get_tree().create_tween().parallel().tween_property($Camera2D, "position", Vector2(604, -109), 1)
	await get_tree().create_timer(1.1).timeout
	get_tree().change_scene_to_file("res://Scenes/the_end_level/the_end.tscn")
