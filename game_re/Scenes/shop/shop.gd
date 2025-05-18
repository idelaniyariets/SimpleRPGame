extends Node2D
#машазин на 2й локации
@onready var player = $"../Player"

func _on_area_2d_body_entered(_body):
	#речь игрока 1
	GlobalVar.can_move = false
	$Label.text = "Есть тут кто!?"
	await get_tree().create_timer(2).timeout
	$Label.text = "Хм..."
	await get_tree().create_timer(1).timeout
	$Label.text = ""
	$Area2D/CollisionShape2D.disabled = true
	GlobalVar.can_move = true

func _on_area_2d_2_body_entered(_body):
	#речь игрока 2, перемещение на слудующий уровень
	GlobalVar.can_move = false
	$Label.text = "A...a?"
	await get_tree().create_timer(1).timeout
	$Label.text = "AAAAAA"
	await get_tree().create_timer(0.5).timeout
	$Label.text = ""
	get_tree().change_scene_to_file("res://Scenes/Level_3/level_3.tscn")
	player.camera.zoom.x = 2
	player.camera.zoom.y = 2
	GlobalVar.can_move = true
