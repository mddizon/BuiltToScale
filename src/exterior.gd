extends Node2D

@export var enemy_spawn_chance = 1
@export var asteroid_spawn_chance = 1
@export var battleship_spawn_chance = 1

var enemy = preload("res://Scenes/small_enemy.tscn")
var asteroid = preload("res://Scenes/asteroid.tscn")
var big_enemy = preload("res://Scenes/big_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://Scenes/asteroid.tscn")
	for i in $EnemySpawnLocations.get_children():
		if randf() < enemy_spawn_chance:
			var dude = enemy.instantiate();
			dude.position = i.position
			add_child(dude)
	for i in $AsteroidSpawnLocations.get_children():
		if randf() < asteroid_spawn_chance:
			var dude = asteroid.instantiate();
			dude.position = i.position
			add_child(dude)
	for i in $BattleshipSpawnLocations.get_children():
		if randf() < battleship_spawn_chance:
			var dude = big_enemy.instantiate();
			dude.position = i.position
			add_child(dude)
	return
	const numAsteroids = 10.0
	const arenaRadius = 10000.0
	for i in range(numAsteroids):
		for j in range(numAsteroids):
			var instance = scene.instantiate()
			add_child(instance)
			
			#Random position in grid
			var x = i * ((arenaRadius * 2) / numAsteroids) - arenaRadius
			var y = j * ((arenaRadius * 2) / numAsteroids) - arenaRadius
			var randomOffset = Vector2(randf_range(-100, 100), randf_range(-100, 100))
			instance.global_position = Vector2(x, y) + randomOffset
			
			#Random size
			var asteroidScale = randf_range(0.1, 1.0)
			instance.set_asteroid_scale(asteroidScale)

			#Random rotation
			var randomRotation = randf_range(0, 360)
			instance.rotation = randomRotation

			#Random impulse
			var impuleScale = 500
			var randomImpulse = Vector2(randf_range(-impuleScale, impuleScale), randf_range(-impuleScale, impuleScale))
			instance.apply_impulse(randomImpulse)
