extends Node2D#механика получения урона для мобов

signal no_hp()
signal damage_recived()

var player_dmg

@onready var healthbar = $TextureProgressBar
@onready var damagetext = $Label
@onready var animation_player = $AnimationPlayer

var hp = 1500:#хп босса
	set (value):
		hp = value
		healthbar.value = hp
		if hp<=0:
			healthbar.visible = false
		else:
			healthbar.visible = true

func _ready() -> void:
	#принятие сигналов от игрока
	Signals.player_attack.connect(Callable(self, "_on_player_attack"))
	Signals.night_player_attack.connect(Callable(self, "_on_night_player_attack"))
	damagetext.modulate.a = 0
	healthbar.max_value = hp
	healthbar.visible = false

func _on_player_attack(player_damage):
	#переприсваивание переменной по тригеру
	player_dmg = player_damage

func _on_night_player_attack(night_player_damage):
	#см функцию выше
	player_dmg = night_player_damage


func _on_hurt_box_area_entered(_area):
	#уменьшение здаровья моба по входу оружия игрока в область
	await get_tree().create_timer(0.1).timeout
	hp -= player_dmg
	damagetext.text = str(player_dmg)
	animation_player.play("new_animation")
	if hp<=0:
		emit_signal("no_hp")
	else:
		emit_signal("damage_recived")
