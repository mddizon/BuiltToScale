extends Node

@export var health = 1
@export var isPlayer = false
@export var isEnemy = false
@export var isAsteroid = false

@onready var currentHealth = health

#TODO put dealth effect here

func take_damage(damage: int, source: Node):
	var previousHealth = currentHealth
	currentHealth -= damage
	SignalBus.damage_taken.emit(damage, currentHealth, previousHealth, source, self)
	if (isPlayer):
		SignalBus.player_damage_taken.emit(damage)
	if currentHealth <= 0:
		die()
	
func die():
	get_parent().queue_free()
