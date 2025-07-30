extends Control

@onready var but_3 = $Panel/VBoxContainer/Button3

func _ready() -> void:
	#получение сигналов от действий игрока
	Signals.hide.connect(Callable(self, "_on_hide"))
	Signals.show.connect(Callable(self, "_on_show"))

func _on_button_pressed() -> void:
	#кнопка продолжения игры
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	Manager.game_paused = false

func _on_button_2_pressed() -> void:
	#кнопка сохранить отправляет сигнал
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	Signals.save.emit()
	Manager.game_paused = false

func _on_button_3_pressed():
	#функция загрузки
	#проверяет есть ли файлы в системе и загружает игру
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	if FileAccess.file_exists("user://the_game_save.tgs"):
		Signals.load.emit()
		Manager.game_paused = false
	else:
		but_3.text = "No Saves"

func _on_button_4_pressed() -> void:
	#кнопка выхода в меню
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	Manager.game_paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")

#показ / скрытие меню
func _on_show():
	self.visible = true

func _on_hide():
	self.visible = false
