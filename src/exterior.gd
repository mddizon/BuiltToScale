extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://Scenes/asteroid.tscn")
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_ship_position():
	return get_node("PlayerShip").global_position
