extends Area2D

@export var speed = 1000
@export var damage = 1

func _ready():
	pass

func _physics_process(delta):
	position += Vector2.DOWN.rotated(rotation) * speed * delta

func _on_life_timer_timeout():
	die()

func die() -> void:
	queue_free()

func _on_body_entered(body):
	die()
