extends Node

signal health_changed(new_value: int)

@export var health = 1
@export var isPlayer = false
@export var isEnemy = false
@export var isAsteroid = false
@export var deathParticle: PackedScene

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
	
func die():
	var parent = get_parent()
	#play particle effect
	var particle = deathParticle.instantiate()
	particle.global_position = parent.global_position
	particle.rotation = parent.global_rotation
	particle.emitting = true
	get_tree().current_scene.add_child(particle)
	
	parent.queue_free()
