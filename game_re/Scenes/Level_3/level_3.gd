extends Node2D



@onready var player = $Player


func _ready() -> void:
	GlobalVar.can_move = false
	GlobalVar.can_move = true
	if GlobalVar.loaded == true:
		player.position = GlobalVar.player_pos
		GlobalVar.loaded = false
	player.healthbar.value = GlobalVar.player_health
	GlobalVar.level = 3

func _process(_delta: float) -> void:
	player.position = GlobalVar.player_pos


func _on_area_2d_body_entered(_body):
	GlobalVar.can_change_level = true
	$Label.text = "Press f to go to the next level"


func _on_area_2d_2_body_entered(_body):
	GlobalVar.can_move = false
	$Label2.text = "что!? Я снова здесь, но... как?"
	await get_tree().create_timer(2).timeout
	$Label2.text = "Прав был тот мужик, странные эти места"
	await get_tree().create_timer(2).timeout
	$Label2.text = "А это еще что за хрень!?"
	await get_tree().create_timer(2).timeout
	$Label2.text = "Хах, вот мне и пригодится мой меч!"
	await get_tree().create_timer(1).timeout
	$Label2.text = ""
	$Area2D2/CollisionShape2D.disabled = true
	GlobalVar.can_move = true


func _on_area_2d_3_body_entered(_body):
	GlobalVar.can_move = false
	$Label3.text = "Наверное отсюда вылез..."
	await get_tree().create_timer(1).timeout
	$Label3.text = "Значит мне туда и надо!"
	await get_tree().create_timer(1).timeout
	$Light/DirectionalLight2D.energy = 10
	$Player.visible = false
	player.position.x += 300
	$Area2D3/CollisionShape2D.disabled = true
	GlobalVar.can_move = true
	$Area2D6/CollisionShape2D2.disabled = false


func _on_area_2d_4_body_entered(_body):
	GlobalVar.can_move = false
	await get_tree().create_timer(1).timeout
	GlobalVar.can_move = true


func _on_area_2d_6_body_entered(_body):
	GlobalVar.can_move = false
	player.position.x += 50
	await get_tree().create_timer(0.2).timeout
	$Label4.text = "Похоже на какой - то странный барьер"
	await  get_tree().create_timer(0.8).timeout
	$Label4.text = ""
	GlobalVar.can_move = true


func _on_area_2d_5_body_entered(_body):
	get_tree().change_scene_to_file("res://Scenes/level_4/level_4.tscn")
