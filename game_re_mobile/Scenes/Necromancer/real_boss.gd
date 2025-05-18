extends CharacterBody2D

#boss

@onready var player_ = $"../Player"

var mashroom_preload = preload("res://Scenes/enemy/skelet/mushroom.tscn")

var dead = false
#var player
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damage = 90
#attack vectors
var positions = [Vector2(9161, 280),
Vector2(9660, 280),
Vector2(9390, 280),
Vector2(9390, 565)
]

enum{
	IDLE,
	MOVE,
	ATTACK,
	HEAL,
	SUMMON,
	HIT,
	DEATH,
	WAIT, 
	IDLE_HIT,
	ARRIVAL
}

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	$HurtBox/CollisionShape2D.disabled = true
	

var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			MOVE:
				move_state()
			ATTACK:
				attack_state()
			HEAL:
				heal_state()
			SUMMON:
				summon_state()
			HIT:
				hit_state()
			DEATH:
				death_state()
			WAIT:
				wait_state()
			IDLE_HIT:
				idle_hit_state()
			ARRIVAL:
				arrival_state()

func _physics_process(delta: float) -> void:
	#player = GlobalVar.player_pos
	#add the gravity
	#if not is_on_floor():
		#velocity.y += gravity * delta
	if state == IDLE:
		idle_state()
	
	if state == MOVE:
		move_state()
	
	if $mobe_health.hp == 0:
		$Timer.stop()
		state = DEATH

	move_and_slide()

func idle_state():
	anim.play("IDLE")
	if GlobalVar.attack == true and $mobe_health.hp > 0:
		state = MOVE


func move_state():
	anim.play("MOVE")
	randomize()
	#randi_range(0,2)
	var a = 2
	if a ==0:
		get_tree().create_tween().tween_property(self, "position", positions[0], 1)
		get_tree().create_tween().tween_property($"../Node2D", "modulate", Color8(255, 255, 255, 255), 1)
		#await get_tree().create_timer(1).timeout
		state = ATTACK
	if a == 1:
		get_tree().create_tween().tween_property(self, "position", positions[1], 1)
		#await get_tree().create_timer(1).timeout
		state = HEAL
	if a == 2:
		get_tree().create_tween().tween_property(self, "position", positions[2], 1)
		#await get_tree().create_timer(1).timeout
		state = SUMMON
	#print("b")
	#print(self.position)

func attack_state():
	await get_tree().create_timer(1).timeout
	anim.play("ATTACK")
	$HitBox/CollisionShape2D.disabled = false
	$HitBox/CollisionShape2D2.disabled = false
	$HitBox/CollisionShape2D3.disabled = false
	$HitBox/CollisionShape2D4.disabled = false
	$HitBox/CollisionShape2D5.disabled = false
	$HitBox/CollisionShape2D6.disabled = false
	$HitBox/CollisionShape2D7.disabled = false
	
	$HitBox/CollisionShape2D/Health1.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D2/Health2.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D3/Health3.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D4/Health4.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D5/Health5.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D6/Health6.modulate = Color8(255, 255, 255, 255)
	$HitBox/CollisionShape2D7/Health7.modulate = Color8(255, 255, 255, 255)
	
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D, "position", Vector2(-200, self.position.y-700), 0.5)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D7, "position", Vector2(400, self.position.y-700), 0.5)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D2, "position", Vector2(-100, self.position.y-700), 0.6)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D6, "position", Vector2(300, self.position.y-700), 0.6)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D3, "position", Vector2(0, self.position.y-700), 0.7)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D5, "position", Vector2(200, self.position.y-700), 0.7)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D4, "position", Vector2(100, self.position.y-700), 0.8)
	
	get_tree().create_tween().tween_property($"../Node2D", "modulate", Color8(255, 255, 255, 0), 1)
	
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D, "position", Vector2(-200, self.position.y+700), 0.5)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D7, "position", Vector2(400, self.position.y+700), 0.5)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D2, "position", Vector2(-100, self.position.y+700), 0.6)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D6, "position", Vector2(300, self.position.y+700), 0.6)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D3, "position", Vector2(0, self.position.y+700), 0.7)
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D5, "position", Vector2(200, self.position.y+700), 0.7)
	await get_tree().create_timer(0.1).timeout
	get_tree().create_tween().tween_property($HitBox/CollisionShape2D4, "position", Vector2(100, self.position.y+700), 0.8)
	
	$HitBox/CollisionShape2D/Health1.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D2/Health2.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D3/Health3.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D4/Health4.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D5/Health5.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D6/Health6.modulate = Color8(255, 255, 255, 0)
	$HitBox/CollisionShape2D7/Health7.modulate = Color8(255, 255, 255, 0)
	
	$HitBox/CollisionShape2D.disabled = true
	$HitBox/CollisionShape2D2.disabled = true
	$HitBox/CollisionShape2D3.disabled = true
	$HitBox/CollisionShape2D4.disabled = true
	$HitBox/CollisionShape2D5.disabled = true
	$HitBox/CollisionShape2D6.disabled = true
	$HitBox/CollisionShape2D7.disabled = true
	
	await anim.animation_finished
	
	get_tree().create_tween().tween_property(self, "position", positions[3], 1)
	anim.play("MOVE")
	$HurtBox/CollisionShape2D.disabled = false
	await get_tree().create_timer(1).timeout
	state = WAIT

func heal_state():
	await get_tree().create_timer(1).timeout
	anim.play("HEAL")
	if $mobe_health.hp + $mobe_health.hp*0.2 > 1000:
		pass
	elif $mobe_health.hp + $mobe_health.hp*0.2 < 1000:
		$mobe_health.hp += $mobe_health.hp*0.2
	await anim.animation_finished
	get_tree().create_tween().tween_property(self, "position", positions[3], 1)
	$HurtBox/CollisionShape2D.disabled = false
	await get_tree().create_timer(3).timeout
	state = WAIT

func summon_state():
	await get_tree().create_timer(1).timeout
	var mashroom = mashroom_preload.instantiate()
	var mashroom1 = mashroom_preload.instantiate()
	mashroom.position = Vector2(9090, 561)
	$"../summoned".add_child(mashroom)
	mashroom1.position = Vector2(9636, 600)
	$"../summoned".add_child(mashroom1)
	anim.play("SUMMON")
	await anim.animation_finished
	get_tree().create_tween().tween_property(self, "position", positions[3], 1)
	anim.play("MOVE")
	$HurtBox/CollisionShape2D.disabled = false
	await get_tree().create_timer(1).timeout
	state = WAIT
	
func hit_state():
	#$HurtBox/CollisionShape2D.disabled = true
	anim.play("HIT")
	await anim.animation_finished
	state = IDLE_HIT

func death_state():
	$"../summoned".queue_free()
	GlobalVar.can_move = false
	$"../AudioStreamPlayer".stop()
	$"../AudioStreamPlayer2".play()
	$"../CanvasLayer/AnimatedSprite2D".visible = true
	$"../CanvasLayer/AnimatedSprite2D3".visible = true
	$"../CanvasLayer/Label2".position = Vector2(800, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Кхе-кхе... Доволен своей победой?", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "Хахаха, еще как", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "Такой легкости и эйфории я не ощущал уже давно", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(620, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Чтож, тогда мои слова вернут тебя с небес на землю", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(545, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Вы, люди, даже не отдаете себе отчет о том, что происходит", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(680, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Все живете мечтами и своими переживаниями", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(620, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "А сняв розовые очки вы видите нас - своих демонов", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(780, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Не признаёте нас, убиваете. А толку?!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(565, 50)
	$"../CanvasLayer/Label2".add_theme_color_override("font_color", Color8(255, 0, 0))
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Не изменив мышление, вы ничего не добъетесь! НИЧЕГО!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(615, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "А все так же продолжите спихивать проблемы на нас.", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(560, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Хоть вы и люди, но человечного от вас ничего не осталось!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(750, 50)
	$"../CanvasLayer/Label2".add_theme_color_override("font_color", Color8(168, 0, 186))
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Я даже рад уйти из этого мира. Прощай", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(700, 50)
	$"../CanvasLayer/Label2".add_theme_color_override("font_color", Color8(0, 0, 0))
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "И знай, ты уже не будешь счастлив. Никогда!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	$"../CanvasLayer/AnimatedSprite2D3".visible = false
	$"../CanvasLayer/AnimatedSprite2D".visible = false
	await get_tree().create_timer(1).timeout
	
	anim.play("MOVE")
	get_tree().create_tween().tween_property(self, "position", positions[2], 1)
	await get_tree().create_timer(1.1).timeout
	
	anim.play("DEATH")
	await anim.animation_finished
	get_tree().create_tween().parallel().tween_property($"../TileMapLayer5", "position", Vector2($"../TileMapLayer5".position.x, $"../TileMapLayer5".position.y + 500), 2)
	get_tree().create_tween().parallel().tween_property(player_.camera, "zoom", Vector2(1.8, 1.8), 1)
	GlobalVar.can_move = true
	#player_.camera.zoom.x = 1.8
	#player_.camera.zoom.y = 1.8
	queue_free()

func wait_state():
	$Timer.start()
	anim.play("IDLE")

func idle_hit_state():
	anim.play("IDLE")

func arrival_state():
	$"../CanvasLayer/Label2".add_theme_color_override("font_color", Color8(168, 0, 186, 255))
	anim.visible = true
	get_tree().create_tween().tween_property(self, 'position', Vector2(GlobalVar.player_pos.x + 250, GlobalVar.player_pos.y-200), 1)
	anim.play("ARRIVAL")
	await anim.animation_finished
	anim.play("IDLE")
	$"../CanvasLayer/AnimatedSprite2D3".visible = true
	$"../CanvasLayer/AnimatedSprite2D".visible = true
	$"../CanvasLayer/Label2".position = Vector2(1070, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Ну привет", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "Но я же тебя убил, с тобой покончено!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(840, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Хах, мы как раз и не закончили", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(400, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Кстати, демон внутри тебя, как и тот, которого ты 'убил' - моя марионетка", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(700, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Короче говоря, убъешь меня - изгонишь его", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	$"../CanvasLayer/Label2".position = Vector2(860, 50)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "Но ты меня не убъешь. Удачи)", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label2", "text", "", 1)
	await get_tree().create_timer(1).timeout
	
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 255), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "Ты труп!", 1)
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "modulate", Color8(255, 255, 255, 0), 1)
	get_tree().create_tween().parallel().tween_property($"../CanvasLayer/Label", "text", "", 1)
	$"../CanvasLayer/AnimatedSprite2D".visible = false
	$"../CanvasLayer/AnimatedSprite2D3".visible = false

	
	state = IDLE
	GlobalVar.attack = true

func _on_mobe_health_damage_recived():
	state = HIT

func _on_mobe_health_no_hp():
	dead = true
	state = DEATH

func _on_timer_timeout():
	$HurtBox/CollisionShape2D.disabled = true
	$Timer.stop()
	if dead != true:
		state = MOVE


func _on_area_2d_8_body_entered(body: Node2D) -> void:
	state = ARRIVAL


func _on_hit_box_area_entered(area: Area2D) -> void:
	Signals.enemy_attack.emit(damage)
