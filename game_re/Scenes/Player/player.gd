extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -400.0
var boost = 1
var not_attack = true
var is_stronger = false
var stronger =  false
var shift_cd = false
var attack_cd = false
var change_cd = false
var buff = false
var  speed = SPEED*30*boost
var player_damage = 15
var night_player_damage = player_damage + 0.2*player_damage
var level = 1
var cd_time = 2
var state = IDLE
@onready var healthbar = $TextureProgressBar
@onready var camera = $Camera2D
@onready var anim = $AnimatedSprite2D
@onready var animat = $AnimatedSprite2D2
@onready var animationPlayer = $AnimationPlayer
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
@onready var audio_stream_player_6: AudioStreamPlayer = $AudioStreamPlayer6

enum {
	IDLE,
	RUN,
	JUMP,
	ATTACK,
	SHIFT,
	SHIELD,
	CHANGE,
	RETURN,
	DAMAGE,
	DAMAGE_C,
	DEATH,
	CHANGE_CAT,
	BUFF
}


func _ready():
	Signals.enemy_attack.connect(Callable(self, "_on_damage_received"))
	healthbar.visible = false
	$TextureProgressBar2.visible = false

func _physics_process(delta: float) -> void:
	healthbar.max_value = GlobalVar.player_health_max_value
	healthbar.value = GlobalVar.player_health
	player_damage = GlobalVar.player_damage
	night_player_damage = GlobalVar.night_player_damage
	$TextureProgressBar2.value = $Timer.time_left
	if level == 2:
		$Camera2D.zoom = 2

	if GlobalVar.can_change_level == true:
		if Input.is_action_just_pressed("change_level"):
			level += 1
			get_tree().change_scene_to_file("res://Scenes/Level_2/level_2.tscn")
			GlobalVar.can_change_level = false

	if GlobalVar.can_move == false:
		velocity.x = 0
		state = IDLE
		if GlobalVar.can_move == true:
			state = IDLE


	match state:
		IDLE:
			idle_state()
		RUN:
			run_state()
		ATTACK:
			attack_state()
		JUMP:
			jump_state()
		SHIELD:
			shield_state()
		SHIFT:
			shift_state()
		CHANGE:
			change_state()
		RETURN:
			return_state()
		DAMAGE:
			damage_state()
		DAMAGE_C:
			pass
		DEATH:
			death_state()
		CHANGE_CAT:
			change_cat_state()
		BUFF:
			buff_state()


	if not is_on_floor():
		velocity += get_gravity() * delta

	#if velocity.y >0 and stronger == false:
		#animationPlayer.play("fall")
	#elif velocity.y >=0 and stronger == true:
		#animationPlayer.play("fall_1")

	if Input.is_action_just_pressed("g"):
		Signals.g.emit()

	move_and_slide()
	
	GlobalVar.player_pos = self.position



func idle_state():
	if stronger == false:
		animationPlayer.play("Idle")
	else:
		animationPlayer.play("Idle_1")
	
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state = RUN

	if Input.is_action_just_pressed("attack") and attack_cd == false:
		state = ATTACK

	if Input.is_action_just_pressed("jump"):
		state = JUMP

	if Input.is_action_just_pressed("shift") and shift_cd == false and GlobalVar.level >= 2:
		state = SHIFT

	if Input.is_action_just_pressed("change") and GlobalVar.level >= 6 and change_cd == false:
		if stronger == false:
			state = CHANGE
		elif stronger == true:
			state = RETURN

	if Input.is_action_just_pressed("return") and stronger == true and GlobalVar.level >= 6:
		state = RETURN

	if Input.is_action_pressed("shield") and stronger == false:
		state = SHIELD

	if Input.is_action_just_pressed("cast"):
		state = BUFF

	if GlobalVar.player_health <= 0:
		state = DEATH


func run_state():
	if GlobalVar.can_move == true:
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			if velocity.y==0 and stronger == false:
				animationPlayer.play("run")
			elif velocity.y == 0 and stronger == true:
				animationPlayer.play("run_1")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.x == 0 and stronger == false:
				animationPlayer.play("Idle")
			else:
				animationPlayer.play("Idle_1")

		if direction == -1:
			anim.flip_h = true
			$AttackDirection.rotation_degrees = 180
		elif direction == 1:
			anim.flip_h = false
			$AttackDirection.rotation_degrees = 0

		if velocity.x == 0 and velocity.y == 0:
			state = IDLE

		if Input.is_action_just_pressed("attack") and attack_cd == false:
			state = ATTACK

		if Input.is_action_just_pressed("jump"):
			state = JUMP

		if Input.is_action_just_pressed("shift") and shift_cd == false:
			state = SHIFT

		if Input.is_action_pressed("shield"):
			state = SHIELD

		if GlobalVar.player_health<=0:
			state = DEATH


func attack_state():
	velocity.x = 0
	#Signals.player_attack.emit(player_damage)
	if stronger == false:
		if buff == true:
			player_damage += 0.5*player_damage
			animationPlayer.play("attack_speed")
		else:
			animationPlayer.play("attack")
	else:
		animationPlayer.play("attack_1")
	await animationPlayer.animation_finished
	attack_cooldown()
	if Input.is_action_just_pressed("attack") and buff == true:
		state = ATTACK
	state = IDLE

	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state = RUN

	if Input.is_action_just_pressed("jump"):
		state = JUMP

	if Input.is_action_just_pressed("shift") and shift_cd == false:
		state = SHIFT


func jump_state():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		if stronger == false:
			animationPlayer.play('jump')
			#await animationPlayer.animation_finished
			#velocity.y = 0
			state = RUN
		elif stronger == true:
			animationPlayer.play("jump_1")
			#await animationPlayer.animation_finished
			#velocity.y = 0
			state = RUN

		if velocity.y ==0 and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
			state = RUN

		if velocity.x == 0 and velocity.y == 0:
			state = IDLE

		if Input.is_action_just_pressed("shift") and shift_cd == false:
			state = SHIFT

		if GlobalVar.player_health <=0:
			state = DEATH


func shift_state():
	var direction := Input.get_axis("left", "right")
	if direction:
		animat.visible = true
		anim.visible = false
		audio_stream_player_6.play()
		velocity.x = direction * speed
		if velocity.y==0 or velocity.y!=0:
			animat.play("smoke")
			shift_cooldown()
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			shift_cooldown()
			#animat.play("smoke")
		if velocity.y ==0 and stronger == false:
			animationPlayer.play("Idle")
			shift_cooldown()
		elif stronger == true and velocity.x == 0:
			animationPlayer.play("Idle_1")
			shift_cooldown()
	if direction == -1:
		anim.flip_h = true
		$AttackDirection.rotation_degrees = 180
	elif direction == 1:
		anim.flip_h = false
		$AttackDirection.rotation_degrees = 0

	if velocity.x == 0 and velocity.y == 0:
		state = IDLE

	if Input.is_action_just_pressed("jump"):
		state = JUMP

	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state = RUN

	if Input.is_action_pressed("attack") and attack_cd == false:
		state = ATTACK


func shield_state():
	velocity.x = 0
	animationPlayer.play("shield")
	if Input.is_action_just_released("shield"):
		state = IDLE


func change_cooldown():
	change_cd = true
	await get_tree().create_timer(30).timeout
	change_cd = false


func shift_cooldown():
	shift_cd = true
	await get_tree().create_timer(cd_time).timeout
	shift_cd = false


func attack_cooldown():
	attack_cd = true
	await get_tree().create_timer(0.4).timeout
	attack_cd = false


func change_state():
	$Timer.start()
	$TextureProgressBar2.visible = true
	velocity.x = 0
	animationPlayer.play("transition")
	await animationPlayer.animation_finished
	stronger = true
	state = IDLE


func return_state():
	$Timer.stop()
	$TextureProgressBar2.visible = false
	not_attack = false
	velocity.x = 0
	animationPlayer.play("death_1")
	await animationPlayer.animation_finished
	change_cooldown()
	stronger = false
	not_attack = true
	state = IDLE


func damage_state():
	audio_stream_player_3.play()
	if stronger == false:
		animationPlayer.play("damage")
		await animationPlayer.animation_finished
		state = IDLE
	elif stronger == true:
		animationPlayer.play("hit_1")
		await animationPlayer.animation_finished
		state = IDLE


func buff_state():
	animationPlayer.play("buff")
	buff = true
	cd_time = 0
	speed = SPEED*60
	await animationPlayer.animation_finished
	state = IDLE


func death_state():
	velocity.x = 0
	GlobalVar.player_health = 0
	if stronger == false:
		animationPlayer.play("death")
	else:
		animationPlayer.play("death_1")


func change_cat_state():
	velocity.x = 0
	animationPlayer.play("transition")
	await animationPlayer.animation_finished
	stronger = true
	state = IDLE


func _on_damage_received(enemy_damage):
	healthbar.visible = true
	if state == SHIELD:
		enemy_damage /= 2
		$TextureProgressBar/Label.text = str(enemy_damage)
		$TextureProgressBar/AnimationPlayer.play("new_animation")
	elif stronger == true:
		enemy_damage -= 5
		$TextureProgressBar/Label.text = str(enemy_damage)
		$TextureProgressBar/AnimationPlayer.play("new_animation")
		state = DAMAGE
		damage_anim()
	else:
		state = DAMAGE
		$TextureProgressBar/Label.text = str(enemy_damage)
		$TextureProgressBar/AnimationPlayer.play("new_animation")
		damage_anim()
	GlobalVar.player_health -= enemy_damage
	healthbar.value = GlobalVar.player_health
	printt(GlobalVar.player_health)
	if GlobalVar.player_health<=0:
		state = DEATH


func _on_hit_box_area_entered(_area):
	if stronger == false:
		Signals.player_attack.emit(player_damage)
	elif stronger == true:
		Signals.night_player_attack.emit(night_player_damage)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death" or anim_name == "death_1" and GlobalVar.player_health == 0:
		GlobalVar.player_health = 100
		GlobalVar.player_health_max_value = 100
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/DEATH_SCENE/death_scene.tscn") 


func damage_anim():
	velocity.x = 0
	if $AnimatedSprite2D.flip_h == true:
		velocity.x += 250
	else:
		velocity.x -= 250
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "velocity", Vector2(0,0), 0.2)


func _on_timer_timeout():
	state = RETURN


func _on_animated_sprite_2d_2_animation_finished():
	anim.visible = true
	animat.visible = false


func _on_button_pressed() -> void:
	Manager.game_paused = not(Manager.game_paused)
