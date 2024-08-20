extends Node

signal health_changed(new_value: int)

@export var health = 1
@export var isPlayer = false
@export var isEnemy = false
@export var isAsteroid = false
@export var isPart = false
@export var deathParticle: PackedScene
@export var deathAnimation: PackedScene
@export var deathAnimationScale: int

@onready var currentHealth = health

#TODO put dealth effect here

func take_damage(damage: int, source: Node):
	var previousHealth = currentHealth
	currentHealth -= damage
	health_changed.emit(currentHealth)
	if (isPlayer):
		SignalBus.player_damage_taken.emit(damage)
	if currentHealth <= 0:
		die()
		

	#good for debugging
	#var parent = get_parent()
	# #play animation if present
	# if (deathAnimation != null):
	# 	var animation = deathAnimation.instantiate()
	# 	if not GlobalGameState.is_game_over:
	# 		get_tree().current_scene.add_child(animation)
	# 	animation.global_position = parent.global_position
	# 	animation.scale = Vector2(deathAnimationScale, deathAnimationScale)
	# 	animation.play("new_animation")

	
func die():
	if isEnemy and not isPart:
		SignalBus.enemy_died.emit()
		AudioController.play_game_sound("enemy_damage")
	get_parent().queue_free()
	var parent = get_parent()

	#play animation if present
	if (deathAnimation != null):
		var animation = deathAnimation.instantiate()
		if not GlobalGameState.is_game_over:
			get_tree().current_scene.add_child(animation)
		animation.global_position = parent.global_position
		animation.scale = Vector2(deathAnimationScale, deathAnimationScale)
		animation.play("new_animation")

	#play particle effect
	var particle = deathParticle.instantiate()
	particle.global_position = parent.global_position
	particle.rotation = parent.global_rotation
	particle.emitting = true
	if not GlobalGameState.is_game_over:
		get_tree().current_scene.add_child(particle)
	
	parent.queue_free()
