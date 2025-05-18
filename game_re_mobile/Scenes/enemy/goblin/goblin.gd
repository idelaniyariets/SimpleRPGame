extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var alive = true
var speed = 300
var enemy_damage = 20
var player
var direction
enum {
	IDLE,
	CHASE,
	ATTACK,
	HIT,
	DEATH
}

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
	#Signals.player_pdosition.connect(Callable(self, "_on_player_position"))
	Signals.player_attack.connect(Callable(self, "_on_player_attack"))


func _physics_process(delta: float) -> void:
	player = GlobalVar.player_pos
	#add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	if state == CHASE:
		chase_state()
	
	if $MobHealth.hp <= 0:
		state = DEATH
	
	move_and_slide()



#func _on_player_position(player_pos):
	#player = player_pos


func _on_attack_range_body_entered(_body):
	state = ATTACK


func idle_state():
	velocity.x = 0
	anim.play("IDLE")
	$AttackDirection/AttackRange/CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AttackDirection/AttackRange/DamageBox/HitBox/CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.2).timeout
	$AttackDirection/AttackRange/CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false
	#state = CHASE


func attack_state():
	velocity.x = 0
	anim.play("ATTACK")
	await anim.animation_finished
	#$AttackDirection/AttackRange/CollisionShape2D2.disabled = true
	#Signals.enemy_attack_finished.emit(enemy_damage)
	state = IDLE


func chase_state():
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
	velocity.x = 0
	velocity.x = 0
	anim.play("HIT")
	await anim.animation_finished
	state = IDLE


func death_state():
	velocity.x = 0
	velocity.x = 0
	anim.play("DEATH")
	await anim.animation_finished
	queue_free()


func _on_hit_box_area_entered(_area):
	Signals.enemy_attack.emit(enemy_damage)


func _on_mob_health_damage_recived():
	state = HIT


func _on_mob_health_no_hp():
	state = DEATH


func _on_area_2d_body_entered(_body):
	state = CHASE


func _on_area_2d_body_exited(_body):
	velocity.x = 0
	direction = null
	state = IDLE
