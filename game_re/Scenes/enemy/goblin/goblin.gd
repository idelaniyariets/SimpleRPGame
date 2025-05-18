extends CharacterBody2D
#скрипт гоблина
#переменные
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var alive = true
var speed = 300
var enemy_damage = 20
var player
var direction
#перечисление состояний StateMachine
enum {
	IDLE,
	CHASE,
	ATTACK,
	HIT,
	DEATH
}
#set get переменная сравнивает и устанавливает состояния
var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			CHASE:
				chase_state()
			ATTACK:
				attack_state()
			HIT:
				hit_state()
			DEATH:
				death_state()


@onready var anim = $AnimationPlayer
@onready var animat = $AnimatedSprite2D

func _ready():
	#функцияю пинимает сигналы
	#Signals.player_pdosition.connect(Callable(self, "_on_player_position"))
	Signals.player_attack.connect(Callable(self, "_on_player_attack"))


func _physics_process(delta: float) -> void:
	#постоянное обновление позиции игрока, определение гравитации и возможность двигаться
	player = GlobalVar.player_pos
	#add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	if state == CHASE:
		chase_state()
	
	if $MobHealth.hp <= 0:
		state = DEATH
	
	move_and_slide()

func _on_attack_range_body_entered(_body):
	#изменение состояния при входе игрока в область
	state = ATTACK

func idle_state():
	#основная функция из которой происходят смены состояний
	velocity.x = 0
	anim.play("IDLE")
	$AttackDirection/AttackRange/CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AttackDirection/AttackRange/DamageBox/HitBox/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	$AttackDirection/AttackRange/CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false

func attack_state():
	 #состояние атаки. вызов анимации
	velocity.x = 0
	anim.play("ATTACK")
	await anim.animation_finished
	state = IDLE

func chase_state():
	#состояие погони за игроком. анимация
	anim.play("MOVE")
	direction = (player - self.position).normalized()
	velocity.x = direction.x * speed
	if direction.x < 0:
		animat.flip_h = true
		$AttackDirection.rotation_degrees = 180
	else:
		animat.flip_h = false
		$AttackDirection.rotation_degrees = 0

func hit_state():
	#состояние получения урона. вызов анимации
	velocity.x = 0
	velocity.x = 0
	anim.play("HIT")
	await anim.animation_finished
	state = IDLE

func death_state():
	#состояние смерти. вызов анимации
	velocity.x = 0
	velocity.x = 0
	anim.play("DEATH")
	await anim.animation_finished
	queue_free()

func _on_hit_box_area_entered(_area):
	#отправка сигнала о том, что моб ударил игрока
	Signals.enemy_attack.emit(enemy_damage)

func _on_mob_health_damage_recived():
	#изменение состояния после получения сигнала
	state = HIT

func _on_mob_health_no_hp():
	#изменение состояния после получения сигнала
	state = DEATH

func _on_area_2d_body_entered(_body):
	#изменение состояния после входа игрока в область
	state = CHASE

func _on_area_2d_body_exited(_body):
	#изменение состояния после выхода игрока из области
	velocity.x = 0
	direction = null
	state = IDLE
