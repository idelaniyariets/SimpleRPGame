extends Node2D

@onready var player = $Player1/Player

func _ready() -> void:
	#определение позиции игорока после загрузки
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false

func _on_area_2d_body_entered(_body):
	#затемнение при переходе между уровнями
	GlobalVar.can_change_level = true
	get_tree().create_tween().tween_property($Light/DirectionalLight2D, "energy", 3, 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Level_2/level_2.tscn")
	
