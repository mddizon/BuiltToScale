extends CharacterBody2D

@export var speed = 1000

func player_movement():
	if not visible:
		pass
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		$Animations.animation = "walk"
		$Animations.play()
		#AudioController.play_game_sound('footstep')
	if Input.is_action_pressed("left"):
		global_rotation = deg_to_rad(-90)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("right"):
		global_rotation = deg_to_rad(90)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("up"):
		global_rotation = deg_to_rad(0)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		global_rotation = deg_to_rad(180)
		velocity.x = 0
		velocity.y = speed
	else:
		$Animations.animation = "idle"
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
