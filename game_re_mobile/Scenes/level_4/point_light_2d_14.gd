extends PointLight2D

func _ready() -> void:
	light()

func light():
	var tween = get_tree().create_tween()
	while true:
		tween.tween_property(self, "color", "red", 1)
		tween.tween_property(self, "color", "green", 1)
		tween.tween_property(self, "color", "blue", 1)
		tween.tween_property(self, "color", 00000,1)
