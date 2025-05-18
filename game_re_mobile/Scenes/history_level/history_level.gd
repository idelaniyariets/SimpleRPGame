extends Node2D

func _process(delta: float) -> void:
	$Enemies/AnimatedSprite2D4.play("new_animation")
	$Enemies/AnimatedSprite2D3.play("new_animation")
	$Enemies/AnimatedSprite2D2.play("new_animation")
	$Enemies/AnimatedSprite2D.play("default")
	$Cityzens/AnimatedSprite2D.play("default")
	get_tree().create_tween().parallel().tween_property($Cityzens/AnimatedSprite2D, "position", Vector2(1780, $Enemies/AnimatedSprite2D.position.y), 6)
	get_tree().create_tween().parallel().tween_property($Enemies/AnimatedSprite2D, "position", Vector2(1700, $Enemies/AnimatedSprite2D.position.y), 6)
	#await get_tree().create_timer(2.1).timeout
	#$Enemies/AnimatedSprite2D.stop()
	#$Enemies/AnimatedSprite2D.play("new_animation")
	#$Cityzens/AnimatedSprite2D.stop()
	
