extends CharacterBody2D

var size = Vector2.ZERO

func _ready() -> void:
	$CanvasLayer/AnimatedSprite2D2.visible = false

func _process(delta: float) -> void:
	size = get_viewport().get_visible_rect().size
	self.position = Vector2(size.x-50, self.position.y)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$CanvasLayer/AnimatedSprite2D2.visible = true
		GlobalVar.can_move = false
		$CanvasLayer/Label.position = Vector2(700, 50)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Эй, ты что тут забыл в такой дождь", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
		await get_tree().create_timer(1.5).timeout
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
		await get_tree().create_timer(1.5).timeout
		
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Иди домой, пока совсем не промок", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
		await get_tree().create_timer(1.5).timeout
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
		await get_tree().create_timer(1.5).timeout
	
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Хотя какое мне дело, иди куда шел", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
		await get_tree().create_timer(1.5).timeout
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
		await get_tree().create_timer(3).timeout
		
		$CanvasLayer/Label.position = Vector2(625, 50)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Учти: эти места опасны, будь осторожен", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
		await get_tree().create_timer(1.5).timeout
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
		await get_tree().create_timer(1.5).timeout
		
		$CanvasLayer/Label.position = Vector2(910, 50)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "Может еще увидимся", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 255), 1)
		await get_tree().create_timer(1.5).timeout
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "text", "", 1)
		get_tree().create_tween().parallel().tween_property($CanvasLayer/Label, "modulate", Color8(255, 255, 255, 0), 1)
		$CanvasLayer/AnimatedSprite2D2.visible = false
		print(self.position)
		$Area2D/CollisionShape2D.disabled = true
		$CanvasLayer/Label.text = ""
		$AnimatedSprite2D.play("walk")
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(-100, self.position.y), 8)
		await get_tree().create_timer(2).timeout
		GlobalVar.can_move = true
		await get_tree().create_timer(6).timeout
		print(self.position)
		queue_free()

func hides():
	$AnimatedSprite2D.visible = true
