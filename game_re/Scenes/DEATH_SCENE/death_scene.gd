extends Node2D


func _on_button_pressed():
	#функция для кнопки на экране после смерти
	get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
