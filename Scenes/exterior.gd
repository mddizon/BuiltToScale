extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://Scenes/asteroid.tscn")
	for i in range(10):
		var instance = scene.instantiate()
		add_child(instance)
		instance.global_position = Vector2(randf_range(0, 800 * 10), randf_range(0, 800 * 10))
		instance.global_scale = Vector2(randf_range(0.5, 2), randf_range(0.5, 2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
