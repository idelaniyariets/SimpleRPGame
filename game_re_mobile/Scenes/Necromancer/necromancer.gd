extends CharacterBody2D

@onready var player_ = $"../Player"

var dead = false
var player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damage = 50
#attack vectors
var positions = [Vector2(5014, -685),
 Vector2(4488, -685),
 Vector2(4776, -675),
#idle vectors
 Vector2(4467, -427),
 Vector2(5028, -427),
 Vector2(4728, -430)
]

enum{
	IDLE,
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	HIT,
	DEATH,
	WAIT, 
	IDLE_HIT
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
			ATTACK1:
				attack1_state()
			ATTACK2:
				attack2_state()
			ATTACK3:
				attack3_state()
			HIT:
				hit_state()
			DEATH:
				death_state()
			WAIT:
				wait_state()
			IDLE_HIT:
				idle_hit_state()

func _physics_process(delta: float) -> void:
	player = GlobalVar.player_pos
	#add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	if state == IDLE:
		idle_state()
	
	if state == MOVE:
		move_state()
	
	if $MobHealth_n.hp == 0:
		$Timer.stop()
		state = DEATH

	move_and_slide()

func idle_state():
	anim.play("IDLE")
	if GlobalVar.attack == true and $MobHealth_n.hp > 0:
		state = MOVE


func move_state():
	anim.play("MOVE")
	randomize()
	var a = randi_range(0, 2)
	if a ==0:
		get_tree().create_tween().parallel().tween_property(self, "position", positions[0], 1)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com5", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com6", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com7", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com8", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com9", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com10", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com11", "modulate", Color8(255, 255, 255, 255), 0.5)
		#await get_tree().create_timer(1).timeout
		state = ATTACK1
	if a == 1:
		get_tree().create_tween().tween_property(self, "position", positions[1], 1)
		#await get_tree().create_timer(1).timeout
		state = ATTACK2
	if a == 2:
		get_tree().create_tween().parallel().tween_property(self, "position", positions[2], 1)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com2", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com3", "modulate", Color8(255, 255, 255, 255), 0.5)
		get_tree().create_tween().parallel().tween_property($"../Pngwing_com4", "modulate", Color8(255, 255, 255, 255), 0.5)
		#await get_tree().create_timer(1).timeout
		state = ATTACK3
	#print("b")
	#print(self.position)

func attack1_state():
	await get_tree().create_timer(1).timeout
	anim.play("ATTACK1")
	get_tree().create_tween().tween_property($HitBox2, "position", Vector2(-164, 70), 0.5)
	$HitBox2/CollisionShape2D.disabled = false
	$HitBox2/CollisionShape2D3.disabled = false
	$HitBox2/CollisionShape2D2.disabled = false
	$HitBox2/CollisionShape2D4.disabled = false
	$HitBox2/CollisionShape2D5.disabled = false
	$HitBox2/CollisionShape2D6.disabled = false
	$HitBox2/CollisionShape2D7.disabled = false
	$HitBox2/CollisionShape2D/Sprite2D5.visible = true
	$HitBox2/CollisionShape2D3/Sprite2D6.visible = true
	$HitBox2/CollisionShape2D2/Sprite2D6.visible = true
	$HitBox2/CollisionShape2D4/Sprite2D5.visible = true
	$HitBox2/CollisionShape2D5/Sprite2D5.visible = true
	$HitBox2/CollisionShape2D6/Sprite2D6.visible = true
	$HitBox2/CollisionShape2D7/Sprite2D6.visible = true
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com5", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com6", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com7", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com8", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com9", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com10", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com11", "modulate", Color8(255, 255, 255, 0), 0.5)
	await anim.animation_finished
	get_tree().create_tween().tween_property($HitBox2, "position", Vector2(-164, 260), 0.5)
	$HitBox2/CollisionShape2D.disabled = true
	$HitBox2/CollisionShape2D3.disabled = true
	$HitBox2/CollisionShape2D2.disabled = true
	$HitBox2/CollisionShape2D4.disabled = true
	$HitBox2/CollisionShape2D5.disabled = true
	$HitBox2/CollisionShape2D6.disabled = true
	$HitBox2/CollisionShape2D7.disabled = true
	$HitBox2/CollisionShape2D/Sprite2D5.visible = false
	$HitBox2/CollisionShape2D3/Sprite2D6.visible = false
	$HitBox2/CollisionShape2D2/Sprite2D6.visible = false
	$HitBox2/CollisionShape2D4/Sprite2D5.visible = false
	$HitBox2/CollisionShape2D5/Sprite2D5.visible = false
	$HitBox2/CollisionShape2D6/Sprite2D6.visible = false
	$HitBox2/CollisionShape2D7/Sprite2D6.visible = false
	get_tree().create_tween().tween_property(self, "position", positions[3], 1)
	anim.play("MOVE")
	$HurtBox/CollisionShape2D.disabled = false
	await get_tree().create_timer(1).timeout
	state = WAIT

func attack2_state():
	anim.play("ATTACK2")
	$MobHealth_n.hp += $MobHealth_n.hp/100*20
	await anim.animation_finished
	anim.play("MOVE")
	get_tree().create_tween().tween_property(self, "position", positions[4], 1)
	$HurtBox/CollisionShape2D.disabled = false
	await get_tree().create_timer(3).timeout
	state = WAIT

func attack3_state():
	await get_tree().create_timer(1).timeout
	anim.play("ATTACK3")
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D, "position", Vector2(110, 60), 0.5)
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D4, "position", Vector2(40, 60), 0.5)
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D2, "position", Vector2(-110, 60), 0.5)
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D3, "position", Vector2(-40, 60), 0.5)
	$HitBox/CollisionShape2D.disabled = false
	$HitBox/CollisionShape2D3.disabled = false
	$HitBox/CollisionShape2D2.disabled = false
	$HitBox/CollisionShape2D4.disabled = false
	$HitBox/CollisionShape2D/Sprite2D.visible = true
	$HitBox/CollisionShape2D3/Sprite2D2.visible = true
	$HitBox/CollisionShape2D2/Sprite2D3.visible = true
	$HitBox/CollisionShape2D4/Sprite2D4.visible = true
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com2", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com3", "modulate", Color8(255, 255, 255, 0), 0.5)
	get_tree().create_tween().parallel().tween_property($"../Pngwing_com4", "modulate", Color8(255, 255, 255, 0), 0.5)
	await anim.animation_finished
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D, "position", Vector2(240, 260), 0.5)
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D4, "position", Vector2(-100, 260), 0.5)#-160
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D2, "position", Vector2(-240, 260), 0.5)
	get_tree().create_tween().parallel().tween_property($HitBox/CollisionShape2D3, "position", Vector2(100, 260), 0.5)#160
	$HitBox/CollisionShape2D.disabled = true
	$HitBox/CollisionShape2D3.disabled = true
	$HitBox/CollisionShape2D2.disabled = true
	$HitBox/CollisionShape2D4.disabled = true
	$HitBox/CollisionShape2D/Sprite2D.visible = false
	$HitBox/CollisionShape2D3/Sprite2D2.visible = false
	$HitBox/CollisionShape2D2/Sprite2D3.visible = false
	$HitBox/CollisionShape2D4/Sprite2D4.visible = false
	get_tree().create_tween().tween_property(self, "position", positions[5], 1)
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
	get_tree().create_tween().tween_property($"../TileMapLayer5", "position", Vector2(0, 500), 1)
	$"../TileMapLayer5".enabled = false
	GlobalVar.attack = false
	anim.play("DEATH")
	await anim.animation_finished
	$"../AudioStreamPlayer".stop()
	$"../AudioStreamPlayer2".play()
	player_.camera.zoom.x = 1.8
	player_.camera.zoom.y = 1.8
	queue_free()

func wait_state():
	$Timer.start()
	anim.play("IDLE")

func idle_hit_state():
	anim.play("IDLE")

func _on_hit_box_area_entered(_area):
	Signals.enemy_attack.emit(damage)

func _on_hit_box_2_area_entered(_area):
	Signals.enemy_attack.emit(damage)

func _on_mob_health_n_damage_recived():
	state = HIT

func _on_mob_health_n_no_hp():
	dead = true
	state = DEATH


func _on_timer_timeout():
	$HurtBox/CollisionShape2D.disabled = true
	$Timer.stop()
	if dead != true:
		state = MOVE
