extends Node2D

@onready var anim = $AnimationPlayer
@onready var player = $"../Player"
@onready var wall1 = $"../StaticBody2D/CollisionShape2D"
@onready var wall2: CollisionShape2D = $"../StaticBody2D2/CollisionShape2D"

func _ready() -> void:
	#принимает сигнал
	Signals.ended.connect(Callable(self, "_on_ended"))

func _on_area_2d_body_entered(_body):
	#изменение положения камеры
	#проигрывание анимации катсцены
	player.camera.position.x += 200
	player.camera.position.y -= 200
	GlobalVar.can_move = false
	$AnimatedSprite2D2.play("default")
	anim.play("Trans")
	await get_tree().create_timer(5).timeout
	$AnimatedSprite2D2.stop()
	$Area2D/CollisionShape2D.disabled = true
	anim.play("IDLE")
	Signals.dark.emit()

func _on_ended():
	#код для ожидания конца анимации в уровне
	GlobalVar.can_move = true
	await get_tree().create_timer(18).timeout
	wall1.disabled = true
	wall2.disabled = true
