extends Node
#создание путей и файлов для сохранения переменных
var save_path_level_n_damage = "user://the_game_save_level_n_damage.sus"
var save_path_pos_x = "user://the_game_save_pos_x.sus"
var save_path_pos_y = "user://the_game_save_pos_y.sus"
var save_path_hp = "user://the_game_save_hp.sus"
var save_path_max_hp = "user://the_game_save_max_hp.sus"
var save_path_damage = "user://th_game_save_damage.sus"
var save_path_mob2 = "user://th_game_save_mob2.sus"
var save_path_mob3 = "user://th_game_save_mob3.sus"
var save_path_mob4 = "user://th_game_save_mob4.sus"
var save_path_mob5 = "user://th_game_save_mob6.sus"
var save_path_mob6 = "user://th_game_save_mob7.sus"
var game_paused = false
var active_menu = false

func _ready() -> void:
	#получение сигналов от кнопок
	Signals.save.connect(Callable(self, "_on_save"))
	Signals.load.connect(Callable(self, "_on_load"))
	
func _process(_delta: float) -> void:
	#пауза / снятие с паузы по кнопке
	#активация / деактивация меню
	if Input.is_action_just_pressed("ui_cancel"):
		game_paused = not(game_paused)
	
	if Input.is_action_just_pressed("open_menu"):
		game_paused = not(game_paused)
		active_menu = true
	
	if game_paused == true and active_menu == true:
		get_tree().paused = true
		Signals.show_menu.emit()
	elif game_paused == true and active_menu == false:
		get_tree().paused = true
		Signals.show.emit()
	else:
		get_tree().paused = false
		Signals.hide.emit()
		Signals.hide_menu.emit()
		active_menu = false
	


func save_game():
#C:\Users\User\AppData\Roaming\Godot\app_userdata\Game_re
	#сохранение переменных в определенных файлах под одним путем
	var file = FileAccess.open(save_path_level_n_damage, FileAccess.WRITE)
	var pos_file_x = FileAccess.open(save_path_pos_x, FileAccess.WRITE)
	var pos_file_y = FileAccess.open(save_path_pos_y, FileAccess.WRITE)
	var hp_file = FileAccess.open(save_path_hp, FileAccess.WRITE)
	var max_hp_file = FileAccess.open(save_path_max_hp, FileAccess.WRITE)
	var damage_file = FileAccess.open(save_path_damage, FileAccess.WRITE)
	var mob2_file = FileAccess.open(save_path_mob2, FileAccess.WRITE)
	file.store_var(GlobalVar.level)
	pos_file_x.store_var(GlobalVar.player_pos.x)
	pos_file_y.store_var(GlobalVar.player_pos.y)
	hp_file.store_var(GlobalVar.player_health)
	max_hp_file.store_var(GlobalVar.player_health_max_value)
	damage_file.store_var(GlobalVar.player_damage)
	mob2_file.store_var(GlobalVar.child_list2)
	print_debug("sucsess")
	
func load_game():
	#запись переменных из файлов, сохраненны ранее
	GlobalVar.loaded = true
	GlobalVar.can_move = true
	var file = FileAccess.open(save_path_level_n_damage, FileAccess.READ)
	var pos_file_x = FileAccess.open(save_path_pos_x, FileAccess.READ)
	var pos_file_y = FileAccess.open(save_path_pos_y, FileAccess.READ)
	var hp_file = FileAccess.open(save_path_hp, FileAccess.READ)
	var max_hp_file = FileAccess.open(save_path_max_hp, FileAccess.READ)
	var damage_file = FileAccess.open(save_path_damage, FileAccess.READ)
	var mob2_file = FileAccess.open(save_path_mob2, FileAccess.READ)
	GlobalVar.level = file.get_var(GlobalVar.level)
	GlobalVar.player_pos.x = pos_file_x.get_var(GlobalVar.player_pos.x)
	GlobalVar.player_pos.y = pos_file_y.get_var(GlobalVar.player_pos.y)
	GlobalVar.player_health = hp_file.get_var(GlobalVar.player_health)
	GlobalVar.player_health_max_value = max_hp_file.get_var(GlobalVar.player_health_max_value)
	GlobalVar.player_damage = damage_file.get_var(GlobalVar.player_damage)
	GlobalVar.child_list2 = mob2_file.get_var()
#перемещение игрока на уровни
	if GlobalVar.level == 1:
		get_tree().change_scene_to_file("res://Scenes/Level/level.tscn")
	
	if GlobalVar.level == 2:
		get_tree().change_scene_to_file("res://Scenes/Level_2/level_2.tscn")
	
	if GlobalVar.level == 3:
		get_tree().change_scene_to_file("res://Scenes/Level_3/level_3.tscn")
	
	if GlobalVar.level == 4:
		get_tree().change_scene_to_file("res://Scenes/level_4/level_4.tscn")
	
	if GlobalVar.level == 5:
		get_tree().change_scene_to_file("res://Scenes/Level_5/level_5.tscn")
	
	if GlobalVar.level == 6:
		get_tree().change_scene_to_file("res://Scenes/level_6/level_6.tscn")
	
	if GlobalVar.level == 7:
		get_tree().change_scene_to_file("res://Scenes/level_7/level_7.tscn")

func _on_load():
	#вызов функции загрузки по сигналу
	load_game()

func _on_save():
	#вызов функции сохранения по сигналу
	save_game()


func _on_timer_timeout():
	save_game()
