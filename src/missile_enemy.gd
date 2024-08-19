extends RigidBody2D

@export var speed = 1000

@onready var target = get_node("../PlayerShip")
@onready var health = $Health

func _ready():
	if has_node("Area2D"):
		get_node("Area2D").body_entered.connect(_on_body_entered)
	else:
		print("Missile needs area 2d to detect when to detonate!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = (target.global_position - global_position).normalized()
	apply_central_force(direction * speed)

	rotation = direction.angle() + PI / 2

func _on_body_entered(body):
	health.take_damage(health.health, body)
