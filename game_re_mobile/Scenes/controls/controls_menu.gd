extends Control

func _ready() -> void:
	Signals.show_menu.connect(Callable(self, "_on_show"))
	Signals.hide_menu.connect(Callable(self, "_on_hide"))

func _on_show():
	self.visible = true

func _on_hide():
	self.visible = false


func _on_button_pressed() -> void:
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	Manager.game_paused = not(Manager.game_paused)
