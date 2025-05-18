extends Node2D

@onready var player = $Player


func _ready() -> void:
	GlobalVar.level = 2
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false


func _on_area_2d_body_entered(body):
	$Label.text = "Поздравляем вы нашли священное дерево"
	await get_tree().create_timer(1).timeout
	$Label.text = "Нажмите SHIFT для резкого перемещения"
	await  get_tree().create_timer(1).timeout
	$Label.text = ""
