extends Area2D

signal damaged(node: Node, damage: int)

@export var speed = 1000
@export var damage = 10

func _physics_process(delta):
	position += Vector2.UP.rotated(rotation) * speed * delta

func _on_life_timer_timeout():
	die()

func die() -> void:
	queue_free()

func _on_body_entered(body):
	if body.has_method("on_damage"):
		body.call("on_damage", damage)
	die()
