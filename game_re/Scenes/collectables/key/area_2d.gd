extends CharacterBody2D

@onready var door = $"../TileMapLayer4"
@onready var player = $"../Player"

func _on_area_2d_body_entered(_body):
	#перемещение камеры игрока для катсцены с дверью на локации № 6
	#триггер - заход игрока в область
	player.camera.position = Vector2(-980, -650)
	
	get_tree().create_tween().parallel().tween_property(door, "position", Vector2(door.position.x, door.position.y - 150), 1)
	
	await get_tree().create_timer(1).timeout
	player.camera.position = Vector2.ZERO # возвращение исходной позиции
	
	get_tree().create_tween().parallel().tween_property(self, "position", Vector2(self.position.x, self.position.y - 40), 0.5)#перемещение григгера
	get_tree().create_tween().parallel().tween_property(self, "modulate", Color8(255, 255, 255, 0), 0.5)
	await get_tree().create_timer(0.5).timeout 
	queue_free() #удаление триггера
