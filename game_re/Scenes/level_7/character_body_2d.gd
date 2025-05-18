extends CharacterBody2D #using nowhere

@onready var player = $"../Player"

func _on_area_2d_body_entered(_body):
	GlobalVar.can_move = false
	for i in range (10):
		self.modulate = Color8(255, 255, 255, 255)
		await get_tree().create_timer(0.4).timeout
		self.modulate = Color8(255, 255, 255, 0)
