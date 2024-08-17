extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_asteroid_scale(asteroidScale: float):
	sprite.scale = Vector2(asteroidScale, asteroidScale)
	collider.scale = Vector2(asteroidScale, asteroidScale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
