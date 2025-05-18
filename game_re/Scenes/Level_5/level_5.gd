extends Node2D

@onready var label = $CanvasLayer/Label5
@onready var player = $Player

func _ready() -> void:
	#изменение состояния проигрывание катсцены
	player.state = 7
	$light/DirectionalLight2D.energy = 16
	GlobalVar.can_move = false
	get_tree().create_tween().tween_property($light/DirectionalLight2D, "energy", 0.5, 5)
	await get_tree().create_timer(5).timeout
	label.text = "и что это было... ох"
	await get_tree().create_timer(1).timeout
	label.text = ""
	GlobalVar.can_move = true
	GlobalVar.level = 5
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false
