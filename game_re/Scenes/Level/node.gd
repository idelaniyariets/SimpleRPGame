extends Node
#создание путей и файлов для сохранения переменных
var save_string_path = "user://the_game_save.tgs"
#объявление переменных
var game_paused = false
var active_menu = false
var TO_SAVE
var loaded

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
#C:\Users\User\AppData\Roaming\Godot\app_userdata\Game_desktop
	#сохранение переменных в определенных файлах под одним путем
	TO_SAVE = [GlobalVar.level,
 GlobalVar.player_damage,
 GlobalVar.player_health,
 GlobalVar.player_health_max_value,
 GlobalVar.player_pos.x,
 GlobalVar.player_pos.y]
	var file = FileAccess.open(save_string_path, FileAccess.WRITE)
	file.store_var(TO_SAVE)
	print_debug("sucsess")
	
func load_game():
	#запись переменных из файлов, сохраненны ранее
	GlobalVar.loaded = true
	GlobalVar.can_move = true
	var file = FileAccess.open(save_string_path, FileAccess.READ)
	loaded = file.get_var()
	print(loaded)
	GlobalVar.level = loaded[0]
	GlobalVar.player_damage = loaded[1]
	GlobalVar.player_health = loaded[2]
	GlobalVar.player_health_max_value = loaded[3]
	GlobalVar.player_pos.x = loaded[4]
	GlobalVar.player_pos.y = loaded[5]
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
