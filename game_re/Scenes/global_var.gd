extends Node #список глобальных переменных,
#используемых в коде

var can_move = true

var can_change_level = false

var player_pos = Vector2.ZERO

var just_change = false

var player_health = 100

var attack = false

var player_damage = 15

var night_player_damage = player_damage + 0.2*player_damage

var player_health_max_value = 100

var level = 1

var list = [player_pos.x, player_pos.y]

var loaded = false

var child_list2 = []
