extends Node2D

@onready var button_3 = $CanvasLayer3/HBoxContainer/Button3
@onready var options_button = $CanvasLayer4/HBoxContainer/OptionButton


const RESOLUTIONS : Dictionary = {
	"1280 x 1024": Vector2i(1280, 1024),
	"1366 x 768": Vector2i(1366, 768),
	"1440 x 900": Vector2i(1440, 900),
	"1600 x 900": Vector2i(1600, 900),
	"1920 x 1080": Vector2i(1920, 1080)
}

func _ready():
	options_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()

func add_resolution_items() -> void:
	for resolution_size_tex in RESOLUTIONS:
		options_button.add_item(resolution_size_tex)

func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTIONS.values()[index])

func _on_button_2_pressed():
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	get_tree().quit()


func _on_button_pressed():
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	get_tree().change_scene_to_file("res://Scenes/Level/level.tscn")


func _on_button_3_pressed():
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
#C:\Users\User\AppData\Roaming\Godot\app_userdata\Game_re
	if not FileAccess.file_exists("user://the_game_save_pos_x.sus"):
		print_debug("there is no saves")
		get_tree().create_tween().tween_property(button_3, "text", "Нет сохранений", 0.6)
	else:
		Signals.load.emit()


func _on_button_4_pressed():
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	Manager.game_paused = not(Manager.game_paused)
	Manager.active_menu = true
	#Signals.show_menu.emit()
	print("yep")


func _on_texture_button_pressed() -> void:
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	OS.shell_open("https://t.me/+EdP8aNfFBm00ODky")


func _on_texture_button_2_pressed() -> void:
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	OS.shell_open("https://vk.com/id977678605")
