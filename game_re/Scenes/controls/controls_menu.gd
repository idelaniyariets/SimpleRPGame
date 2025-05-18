extends Control

func _ready() -> void:
	#функция принимающая сигналы и показывающая/скрывающая меню управления
	Signals.show_menu.connect(Callable(self, "_on_show"))
	Signals.hide_menu.connect(Callable(self, "_on_hide"))

func _on_show():
	#показ меню
	self.visible = true

func _on_hide():
	#скрытие меню
	self.visible = false
