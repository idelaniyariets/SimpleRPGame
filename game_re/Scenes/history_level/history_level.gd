extends Node2D

func _process(delta: float) -> void:
	#анимация небольшой катсцены на локации 7
	$Enemies/AnimatedSprite2D4.play("new_animation")
	$Enemies/AnimatedSprite2D3.play("new_animation")
	$Enemies/AnimatedSprite2D2.play("new_animation")
	$Enemies/AnimatedSprite2D.play("default")
	$Cityzens/AnimatedSprite2D.play("default")
	get_tree().create_tween().parallel().tween_property($Cityzens/AnimatedSprite2D, "position", Vector2(1780, $Enemies/AnimatedSprite2D.position.y), 6)
	get_tree().create_tween().parallel().tween_property($Enemies/AnimatedSprite2D, "position", Vector2(1700, $Enemies/AnimatedSprite2D.position.y), 6)
