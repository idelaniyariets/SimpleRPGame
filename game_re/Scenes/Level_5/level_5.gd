extends Node2D

@onready var label = $CanvasLayer/Label5
@onready var player = $Player

func _ready() -> void:
	#изменение состояния проигрывание катсцены
	player.state = 7
	$light/DirectionalLight2D.energy = 1
	GlobalVar.can_move = false
	get_tree().create_tween().tween_property($light/DirectionalLight2D, "energy", 0.5, 5)
	await get_tree().create_timer(5).timeout
	$CanvasLayer/AnimatedSprite2D2.visible = true
	label.text = "и что это было... ох"
	await get_tree().create_timer(1).timeout
	get_tree().create_tween().parallel().tween_property(label, "text", "", 0.5)
	get_tree().create_tween().parallel().tween_property(label, "modulate", Color8(255, 255, 255, 0), 0.5)
	label.modulate = Color8(255,255,255,255)
	get_tree().create_tween().parallel().tween_property($CanvasLayer/AnimatedSprite2D2, "modulate", Color8(255,255,255,0), 0.5)
	$CanvasLayer/AnimatedSprite2D2.modulate = Color8(255,255,255,255)
	$CanvasLayer/AnimatedSprite2D2.visible = false
	GlobalVar.can_move = true
	GlobalVar.level = 5
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false
